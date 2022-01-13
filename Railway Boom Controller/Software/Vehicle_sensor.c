//Vehicle Sensor Modules

//Vehicle Sensing pins
sbit tr_off at RB0_Bit;
sbit car_off at RB1_Bit;
sbit car_bridge at RB2_Bit;
sbit tr_appr at RB3_Bit;
sbit car_appr at RB4_Bit;
sbit tr_bridge at RB5_Bit;
sbit tr_warn at RB6_Bit;


bit tr_warn_flag, tr_appr_flag, tr_bridge_flag, tr_off_flag;
bit car_appr_flag, car_bridge_flag, car_off_flag;
bit tr_stop_flag, tf_stop_flag;
