from nidaqmx import Task
from atiiaftt import FTSensor
import numpy as np
from nidaqmx.stream_readers import AnalogMultiChannelReader
from nidaqmx.constants import AcquisitionType

class ftsensor:
    def __avg(lst):
        return sum(lst) / len(lst)
    
    def convertToFt(voltage):
        return FTSensor().convertToFt(voltage)

    def __init__(self, calibration_file_path="FT44764\FT44764.cal", tool_offset=[0,0,0,0,0,0]):
        self.calibration_file_path = calibration_file_path
        self.tool_offset = tool_offset
        self.bias = None
        self.channel_number = 6
        self.sampling_freq = 6400
        self.read_freq = 64
        self.sample_number = self.sampling_freq//self.read_freq
        self.raw_readings = np.zeros((self.channel_number, self.sample_number), dtype=np.float64)
        
        self.sensor = FTSensor()
        self.calibrate(calibration_file_path=self.calibration_file_path)
        self.set_tool(self.tool_offset)

    def calibrate(self, calibration_file_path):
        self.sensor.createCalibration(calibration_file_path, 1)
        self.sensor.setForceUnits("N".encode("utf-8"))
        self.sensor.setTorqueUnits("N-m".encode("utf-8"))
        
    def set_tool(self, tool_offset):
        self.sensor.setToolTransform(tool_offset, "mm".encode("utf-8"), "deg".encode("utf-8"))

    def start_task(self):
        self.task = Task()
        for i in range(self.channel_number):
            self.task.ai_channels.add_ai_voltage_chan(f"Dev1/ai{i}")
        self.task.timing.cfg_samp_clk_timing(self.sampling_freq, sample_mode = AcquisitionType.CONTINUOUS, samps_per_chan = self.sample_number)
        self.reader = AnalogMultiChannelReader(self.task.in_stream)
    
    def stop_task(self):
        self.task.close()

    def read_raw_voltage(self):
        self.reader.read_many_sample(data=self.raw_readings, number_of_samples_per_channel=self.sample_number, timeout=1/self.read_freq)
        return self.raw_readings
    
    def read_avg_voltage(self):
        raw_voltage = self.read_raw_voltage()
        return [ftsensor.__avg(channel) for channel in raw_voltage]
    
    def read_raw_ft(self):
        raw_voltage = self.read_raw_voltage()
        return [self.sensor.convertToFt([raw_voltage[i][j] for i in range(self.channel_number)]) for j in range(self.sample_number)]
    
    def read_ft(self):
        avg_voltage = self.read_avg_voltage()
        return self.sensor.convertToFt(avg_voltage)
    
    def set_bias(self, bias=None):
        if bias == None:
            self.bias = self.read_avg_voltage()
        else:
            self.bias = bias
        self.sensor.bias(self.bias)
        return self.bias
    
    def set_sampling_freq(self, freq):
        self.sampling_freq = freq
        self.sample_number = self.sampling_freq//self.read_freq
        return self.sampling_freq

    def set_read_freq(self, freq):
        self.set_read_freq = freq
        self.sample_number = self.sampling_freq//self.read_freq
        return self.sample_number
    
    def get_calibration_file_path(self):
        return self.calibration_file_path
    
    def get_tool_offset(self):
        return self.tool_offset
    
    def get_channel_number(self):
        return self.channel_number
    
    def get_sampling_freq(self):
        return self.sampling_freq
    
    def read_freq(self):
        return self.read_freq
    
    def get_sample_number(self):
        return self.sample_number
    
    def get_bias(self):
        return self.bias
