// This is the main DLL file.

/*modifications
july.22.2005 - Sam Skuce(ATI Industrial Automation) - added support for user setting connection mode
aug.5.2005a - ss - added GetHardwareTempComp
may.21.2008 - ss - added support for buffered gauge collection.
*/

#include "stdafx.h"
#include "ati_compiler.h"
#include "ATICombinedDAQFT.h"

#define FIRST_TORQUE_INDEX 3 /*the index of the first torque reading in 
								the standard output list order (fx, fy, fz, tx, ty, tz)*/
#define NUM_FT_AXES 6		/*the number of force/torque axes*/
#define NUM_STRAIN_GAUGES 6 /*the number of strain gauges*/
#define NUM_MATRIX_ELEMENTS 36		/*the total number of elements in a calibration matrix*/
#define GAUGE_SATURATION_LEVEL 0.995 /*gauges are considered saturated when they reach 99.5% of their maximum load*/

using namespace DAQFTCLIBRARY;


ATICombinedDAQFT::FTSystem::FTSystem() :
m_hiHardware( gcnew ATIDAQHardwareInterface ), m_Calibration ( NULL ),
m_iMaxVoltage( 10 ), m_iMinVoltage( -10 )
{	
	m_dUpperSaturationVoltage = m_iMaxVoltage * GAUGE_SATURATION_LEVEL;
	m_dLowerSaturationVoltage = m_iMinVoltage * GAUGE_SATURATION_LEVEL;
}

ATICombinedDAQFT::FTSystem::~FTSystem()
{
	destroyCalibration( m_Calibration );
}

int ATICombinedDAQFT::FTSystem::LoadCalibrationFile( String ^ calFile, int calibrationIndex )
{
	char cStringCalFile[WHOLE_LOTTA_CHARACTERS];
	int i; /*generic loop/array index*/
	/*first, unload any currently loaded calibration*/
	if( NULL != m_Calibration )
		destroyCalibration( m_Calibration );
	/*copy the calibration file path to the c-string representation*/
	for ( i = 0; (i < calFile->Length) && ( i < ( WHOLE_LOTTA_CHARACTERS - 1 ) ) ; i++ )
	{
		cStringCalFile[i] = (char)calFile[i];
	}	
	cStringCalFile[ calFile->Length ] = '\0';
	m_Calibration = createCalibration( cStringCalFile, calibrationIndex );
	if ( NULL == m_Calibration )
	{
		m_sErrorInfo = gcnew String( "Could not load calibration file successfully" );
		return -1;
	}	
	/*determine max and min voltages and saturation levels*/
	m_iMinVoltage = 0;
	m_iMaxVoltage = m_Calibration->VoltageRange;
	if ( m_Calibration->BiPolar )
	{
		m_iMinVoltage -= ( m_Calibration->VoltageRange / 2 );
		m_dLowerSaturationVoltage = m_iMinVoltage * GAUGE_SATURATION_LEVEL;
		m_iMaxVoltage -= ( m_Calibration->VoltageRange / 2 );
		m_dUpperSaturationVoltage = m_iMaxVoltage * GAUGE_SATURATION_LEVEL;
	}
	return 0;
}


int ATICombinedDAQFT::FTSystem::ReadSingleGaugePoint( array<float64> ^gaugeValues )
{
	unsigned int i; /*generic loop/array index*/
	if ( m_hiHardware->ReadSingleSample( gaugeValues ) )
	{
		m_sErrorInfo = m_hiHardware->GetErrorInfo();
		return -1;
	}
	/*
	precondition: gaugeValues has the most recent gauge readings
	postcondition: will have returned 2 if any gauge is saturated. otherwise, i=number of gauges
	*/
	for( i = 0; i < m_hiHardware->GetNumChannels(); i++ )
	{
		if ( ( gaugeValues[i] > m_dUpperSaturationVoltage ) || ( gaugeValues[i] < m_dLowerSaturationVoltage ) )
		{
			m_sErrorInfo = (String ^) "Gauge Saturation";
			return 2;
		}		
	}
	return 0;
}

String ^ ATICombinedDAQFT::FTSystem::GetErrorInfo()
{
	return m_sErrorInfo;
}

int ATICombinedDAQFT::FTSystem::StartSingleSampleAcquisition( String ^ deviceName, 
																float64 sampleFrequency, 
																int averaging, 
																int firstChannel, 
																bool useTempComp )
{
	int numChannels = NUM_STRAIN_GAUGES + ( (useTempComp)?1:0 );
	int status; /*status of starting the hardware acquisition*/
	status = m_hiHardware->ConfigSingleSampleTask( sampleFrequency, 
													averaging, 
													deviceName, 
													firstChannel, 
													numChannels, 
													m_iMinVoltage, 
													m_iMaxVoltage );
	if ( status )
	{
		if ( status < 0 ) /*hardware error*/
			m_sErrorInfo = m_hiHardware->GetErrorInfo();
		else /*hardware warning*/
			m_sErrorInfo = m_hiHardware->GetErrorCodeDescription( status );
		return -1;
	}
	/*set calibration's use of temp comp*/
	if ( NULL != m_Calibration )
		m_Calibration->cfg.TempCompEnabled = useTempComp;
	return 0;
}

String ^ ATICombinedDAQFT::FTSystem::GetSerialNumber()
{
	if ( NULL == m_Calibration )
	{
		return gcnew String( "" );
	}
	return gcnew String( m_Calibration->Serial );
}

String ^ ATICombinedDAQFT::FTSystem::GetCalibrationDate()
{
	if ( NULL == m_Calibration )
	{
		return gcnew String( "" );
	}
	return gcnew String( m_Calibration->CalDate );
}

float64 ATICombinedDAQFT::FTSystem::GetMaxLoad( int axisIndex )
{
	if ( NULL == m_Calibration )
	{
		return 0;
	}
	float retVal; /*the return value*/
	/*find the maximum load in the current output units, not necessarily the same as the
	calibration units*/
	retVal = m_Calibration->MaxLoads[axisIndex]; /*this is the max load in the calibration
												units*/
	if ( axisIndex < FIRST_TORQUE_INDEX ) /*this is a force axis, convert to output force units*/
	{
		retVal *= ForceConv( m_Calibration->cfg.ForceUnits ) / ForceConv( m_Calibration->ForceUnits );
	} else /*this is a torque axis, convert to output torque units*/
	{
		retVal *= TorqueConv( m_Calibration->cfg.TorqueUnits ) / TorqueConv( m_Calibration->TorqueUnits );
	}
	return retVal;
}

String ^ ATICombinedDAQFT::FTSystem::GetForceUnits()
{
	if ( NULL == m_Calibration )
		return gcnew String( "" );
	return gcnew String( m_Calibration->cfg.ForceUnits );
}


int ATICombinedDAQFT::FTSystem::SetForceUnits( String ^ forceUnits )
{
	char forceUnitsCString[WHOLE_LOTTA_CHARACTERS]; /*c-string representation of force-units*/
	ConvertStringToCString( forceUnits, forceUnitsCString, WHOLE_LOTTA_CHARACTERS );	
	return DAQFTCLIBRARY::SetForceUnits( m_Calibration, forceUnitsCString );
}

int ATICombinedDAQFT::FTSystem::SetTorqueUnits( String ^ torqueUnits )
{
	char torqueUnitsCString[WHOLE_LOTTA_CHARACTERS]; /*c-string representation of torque-units*/
	ConvertStringToCString( torqueUnits, torqueUnitsCString, WHOLE_LOTTA_CHARACTERS );
	return DAQFTCLIBRARY::SetTorqueUnits( m_Calibration, torqueUnitsCString );
}

String ^ ATICombinedDAQFT::FTSystem::GetTorqueUnits( )
{
	if ( NULL == m_Calibration )
		return gcnew String( "" );
	return gcnew String( m_Calibration->cfg.TorqueUnits );
}

bool ATICombinedDAQFT::FTSystem::GetTempCompAvailable()
{
	if ( NULL == m_Calibration )
		return false;	
	return ( 0 != m_Calibration->TempCompAvailable );
}

//int ATICombinedDAQFT::FTSystem::SetTempCompEnabled( bool EnableTempComp )
//{		
//	m_hiHardware->SetNumChannels( NUM_STRAIN_GAUGES + ( (EnableTempComp)?1:0 ) );
//	return SetTempComp( m_Calibration, (int) EnableTempComp );
//}

bool ATICombinedDAQFT::FTSystem::GetTempCompEnabled()
{
	if ( NULL == m_Calibration )
		return false;
	return ( 0 != m_Calibration->cfg.TempCompEnabled );
}

int ATICombinedDAQFT::FTSystem::ToolTransform( array<float64> ^transformVector , String ^ distanceUnits, String ^ angleUnits )
{
	float tempTransforms [6]; /*unmanaged array of transformation values*/
	char cstrDistUnits[WHOLE_LOTTA_CHARACTERS]; /*c-string style distance units string*/
	char cstrAngleUnits[WHOLE_LOTTA_CHARACTERS]; /*c-string sytle angle units string*/
	int i; /*generic loop/array index*/
	ConvertStringToCString( distanceUnits, cstrDistUnits, WHOLE_LOTTA_CHARACTERS );
	ConvertStringToCString( angleUnits, cstrAngleUnits, WHOLE_LOTTA_CHARACTERS );
	/*
	precondition: transformVector has the transformation values
	postcondition: tempTransforms has a copy of transformVector, i = NUM_FT_AXES
	*/
	for ( i = 0; i < NUM_FT_AXES; i++ )
	{
		tempTransforms[i] = (float)transformVector[i];
	}
	return DAQFTCLIBRARY::SetToolTransform( m_Calibration, tempTransforms, cstrDistUnits, cstrAngleUnits );
}

int ATICombinedDAQFT::FTSystem::GetTransformVector( array<float64> ^transformVector )
{
	if ( NULL == m_Calibration )
		return 1; /*calibration not initialized*/
	int i; /*generic loop/array index*/
	for ( i = 0; i < NUM_FT_AXES; i++ )
	{
		transformVector[i] = m_Calibration->cfg.UserTransform.TT[i];
	}
	return 0;
}

String ^ ATICombinedDAQFT::FTSystem::GetTransformDistanceUnits()
{
	if ( NULL == m_Calibration ) 
		return gcnew String( "" );
	return gcnew String( m_Calibration->cfg.UserTransform.DistUnits );
}

String ^ ATICombinedDAQFT::FTSystem::GetTransformAngleUnits()
{
	if ( NULL == m_Calibration )
		return gcnew String( "" );
	return gcnew String( m_Calibration->cfg.UserTransform.AngleUnits );
}

String ^ ATICombinedDAQFT::FTSystem::GetBodyStyle()
{
	if ( NULL == m_Calibration )
		return gcnew String( "" );
	return gcnew String( m_Calibration->BodyStyle );
}

String ^ ATICombinedDAQFT::FTSystem::GetCalibrationType()
{
	if ( NULL == m_Calibration )
		return gcnew String( "" );
	return gcnew String( m_Calibration->PartNumber );
}

int ATICombinedDAQFT::FTSystem::GetWorkingMatrix( 
							array<float64,2> ^matrix  )
{
	if ( NULL == m_Calibration )
		return 1;
	//float tempMatrix __nogc[ NUM_MATRIX_ELEMENTS ];
	/*get matrix returns a one-dimensional array that you have
													to parse into a matrix*/
	int i, j; /*generic loop/aray indices*/
	//GetMatrix( m_Calibration, tempMatrix );
	for ( i = 0; i < NUM_FT_AXES; i++ )
	{
		for( j = 0; j < NUM_STRAIN_GAUGES; j++ )
		{
			matrix[ati_ARRAY_REF(i,j)] = m_Calibration->
						rt.working_matrix[i][j];// tempMatrix[i * NUM_STRAIN_GAUGES + j];
		}
	}
	return 0;
}

int ATICombinedDAQFT::FTSystem::ReadSingleFTRecord( array<double> ^readings )
{
	if ( NULL == m_Calibration )
		return 1;
	int retVal = 0; /*the return value*/
	array<float64> ^gcVoltages = gcnew array<float64>( NUM_STRAIN_GAUGES + 1 ); /*allow an extra reading for the thermistor*/	
	float nogcVoltages [NUM_STRAIN_GAUGES + 1]; /*non-gc version for passing to c library*/
	int i; /*generic loop/array index*/
	float tempResult [NUM_FT_AXES]; /*copy of readings read using C library*/
	retVal = ReadSingleGaugePoint( gcVoltages );
	if ( retVal ){ /*check for error when reading from hardware*/
		if ( 2 == retVal ) return 2; /*saturation*/
		return 1;  /*other error*/
	}
	/*
	precondition: gcVoltages has the voltages from the DAQ card
	postcondition: nogcVoltages has a copy of the data in gcVoltages, i = NUM_STRAIN_GAUGES + 1
	*/
	for ( i = 0; i <= NUM_STRAIN_GAUGES; i++ )
	{
		nogcVoltages[i] = (float)gcVoltages[i];
	}
	DAQFTCLIBRARY::ConvertToFT( m_Calibration, nogcVoltages, tempResult );
	/*
	precondition: tempResult has f/t values
	postcondition: readings has copy of f/t values, i = NUM_FT_AXES
	*/
	for ( i = 0; i < NUM_FT_AXES; i++ )
	{
		readings[i] = tempResult[i];
	}
	return retVal;

}

int ATICombinedDAQFT::FTSystem::BiasCurrentLoad()
{
	if ( NULL == m_Calibration )
		return 1; /*calibration not initialized*/
	array<float64> ^curVoltages = gcnew array<float64>(NUM_STRAIN_GAUGES + 1); /*the current strain gauge load*/
	float nogcVoltages[NUM_STRAIN_GAUGES]; /*voltages that can be passsed to unmanaged c library code*/
	int retVal;
	int i; /*generic loop/array index*/
	retVal = ReadSingleGaugePoint( curVoltages );
	if ( retVal ) return retVal; /*error reading from hardware*/
	/*
	precondition: curVoltages has current reading from hardware
	postcondition: nogcVoltages has a copy of the reading
	*/
	for ( i = 0; i < NUM_STRAIN_GAUGES; i++ )
	{
		nogcVoltages[i] = (float)curVoltages[i];
	}
	DAQFTCLIBRARY::Bias( m_Calibration, nogcVoltages );	
	return retVal;
}

int ATICombinedDAQFT::FTSystem::BiasKnownLoad( array<float64> ^biasVoltages )
{
	if ( NULL == m_Calibration )
		return 1;
	float nogcVoltages [NUM_STRAIN_GAUGES]; /*version of bias voltages which can be passed to the c library*/
	int i; /*generic loop/array index*/
	/*
	precondition: biasVoltages has the known bias voltages
	postcondition: nogcVoltages is a copy of biasVoltages, i = NUM_STRAIN_GAUGES
	*/
	for ( i = 0; i < NUM_STRAIN_GAUGES; i++ )
	{
		nogcVoltages[i] = (float)biasVoltages[i];
	}
	DAQFTCLIBRARY::Bias( m_Calibration, nogcVoltages );
	return 0;
}

int ATICombinedDAQFT::FTSystem::StopAcquisition()
{
	if ( m_hiHardware->StopCollection() )
		return -1;
	return 0;
}

void ATICombinedDAQFT::FTSystem::ConvertStringToCString( String ^ sourceString, char destString[], int destSize )
{
	int i; /*generic loop/array index*/
	for ( i = 0; ( i < destSize ) && ( i < sourceString->Length ); i++ )
	{
		destString[i] = sourceString[i];
	}
	destString[i] = '\0';
}

int ATICombinedDAQFT::FTSystem::StartBufferedAcquisition( String ^ deviceName, float64 sampleFrequency, int averaging, 
	array<float64> ^weights, int firstChannel, bool useTempComp, int bufferSize )
{
	int numChannels = NUM_STRAIN_GAUGES + ( useTempComp?1:0 );
	int32 status = m_hiHardware->ConfigBufferTask( sampleFrequency, averaging, weights, deviceName, firstChannel, numChannels,
		m_iMinVoltage, m_iMaxVoltage, bufferSize );		
	if ( status ) 
	{
		m_sErrorInfo = m_hiHardware->GetErrorCodeDescription( status );
		return -1;
	}
	/*set calibration's use of temp comp*/
	if ( NULL != m_Calibration )
		m_Calibration->cfg.TempCompEnabled = useTempComp;
	return 0;
}



int ATICombinedDAQFT::FTSystem::ReadBufferedGaugeRecords( int numRecords, array<double> ^readings )
{
	long status; /* The status of hardware reads. */
	int numGauges = NUM_STRAIN_GAUGES + ( GetTempCompEnabled()?1:0 ); /* The number of gauges in the scan list. */	
	status = m_hiHardware->ReadBufferedSamples( numRecords, readings );
	if ( status )
	{
		m_sErrorInfo = m_hiHardware->GetErrorCodeDescription( status );
		return (int)status;
	}	
	if ( CheckForGaugeSaturation( readings ) ) status = 2;
	return status;
}

bool ATICombinedDAQFT::FTSystem::CheckForGaugeSaturation( array<double> ^readings )
{
	int i; /* Index into gauge readings. */
	/* Precondition: readings has the gauge readings.
	 * Postcondition: function has returned if any gauge reading is saturated. */
	for( i = 0; i < readings->Length; i++ )
	{
		if ( ( m_dUpperSaturationVoltage < readings[i] ) || 
			 ( m_dLowerSaturationVoltage > readings[i] ) )
		{
			return true;
		}
	}
	return false;
}



int ATICombinedDAQFT::FTSystem::ReadBufferedFTRecords( int numRecords, array<double> ^readings )
{
	if ( NULL == m_Calibration ) /*invalid calibration*/
		return 1;	
	long status; /*the status of hardware reads*/
	int i, j; /*generic loop/array indices*/
	int numGauges = NUM_STRAIN_GAUGES + ( GetTempCompEnabled()?1:0 );
	unsigned int numGaugeValues = numRecords * numGauges;
		/*the number of individual gauge readings*/	
	array<float64> ^gaugeValues = gcnew array<float64>(numGaugeValues); 	
		/*the gauge readings which are fed to the c library*/
	float currentGaugeReadings [ NUM_STRAIN_GAUGES + 1 ]; /*current gauge reading*/
	float currentFTValues [ NUM_FT_AXES ]; /*current f/t reading*/
	status = m_hiHardware->ReadBufferedSamples( numRecords, gaugeValues );		
	if ( status )
	{
		m_sErrorInfo = m_hiHardware->GetErrorCodeDescription( status );
		return (int) status;		
	}
	/*
	precondition: gaugeValues has the buffered gauge readings, numGauges has the
		number of active gauges (6 or 7)
	postcondition: currentGaugeReadings contains the last gauge reading,
		currentFTValues contains the last ft value, readings contains all ft values,
		i = numRecords, j = NUM_FT_AXES, or the function will have already returned due
		to gauge saturation.
	*/
	for ( i = 0; i < numRecords; i++ )
	{
		/*
		precondition: i is the number of the f/t record we are currently calculating.
		postcondition: currentGaugeReadings contains the i'th gauge readings,
			j = numGauges, or the function will have returned due to gauge saturation
		*/
		for ( j = 0; j < numGauges; j++ )
		{
			currentGaugeReadings[j] = (float)gaugeValues[ j + ( i * numGauges ) ];
			/*check for saturation*/
			if ( m_dUpperSaturationVoltage < currentGaugeReadings[j] )
				return 2;
			if ( m_dLowerSaturationVoltage > currentGaugeReadings[j] )
				return 2;
		}
		DAQFTCLIBRARY::ConvertToFT( m_Calibration, currentGaugeReadings, currentFTValues );
		/*
		precondition: currentFTValues has the i'th ft reading from the buffer
		postcondition: j = NUM_FT_AXES, the i'th f/t record in readings contains the values
			from currentFTValues
		*/
		for ( j = 0; j < NUM_FT_AXES; j++ )
		{
			readings[ j + ( i * NUM_FT_AXES ) ] = currentFTValues[j];
		}
	}
	return 0;
	
}


int ATICombinedDAQFT::FTSystem::GetBiasVector( array<double> ^biasVector )
{
	if ( NULL == m_Calibration )
		return 1;
	int i; /*generic loop/array index*/
	/*
	precondition: m_Calibration is a valid calibration
	postcondition: i = NUM_STRAIN_GAUGES, biasVector contains a copy of the calibration's
		bias vector
	*/
	for ( i = 0; i < NUM_STRAIN_GAUGES; i++ )
	{
		biasVector[i] = m_Calibration->rt.bias_vector[i];
	}
	return 0;
}

float64 ATICombinedDAQFT::FTSystem::GetThermistorValue()
{
	if ( NULL == m_Calibration ) return 0;
	return m_Calibration->rt.thermistor;
}

float64 ATICombinedDAQFT::FTSystem::GetBiasSlope( int index )
{
	if ( NULL == m_Calibration ) return 0;
	return m_Calibration->rt.bias_slopes[index];
}

float64 ATICombinedDAQFT::FTSystem::GetGainSlope( int index )
{
	if ( NULL == m_Calibration ) return 0;
	return m_Calibration->rt.gain_slopes[index];
}

/*july.22.2005 - ss - added SetConnectionMode*/
void ATICombinedDAQFT::FTSystem::SetConnectionMode( ConnectionType connType )
{
	m_hiHardware->SetConnectionMode( static_cast<int>( connType ) );
}

/*july.22.2005 - ss - added GetConnectionmode*/
ATICombinedDAQFT::ConnectionType ATICombinedDAQFT::FTSystem::GetConnectionMode( )
{
	return (ATICombinedDAQFT::ConnectionType)m_hiHardware->GetConnectionMode();
}

/*aug.5.2005a - ss - added GetHardwareTempComp*/
bool ATICombinedDAQFT::FTSystem::GetHardwareTempComp( )
{
	if ( m_Calibration->HWTempComp ) return true;
	return false;
}
