set -x
# $1: device for output
#     spk: speaker
#     top-spk: top speaker
#     bot-spk: bottom speaker
#     rcv: receiver
#     spk_hp: speaker high power
#     top-spk_hp: top speaker high power
#     bot-spk_hp: bottom speaker high power
#     us: ultrasound

# tinyplay file.wav [-D card] [-d device] [-p period_size] [-n n_periods]
# sample usage: playback.sh spk
# rcv.wav:-4.5dbfs   spk: -4.8dbfs  ultra: -4.5dbfs  spk_hp:-1.8dbfs

function enable_receiver
{
    echo "enabling receiver"
    tinymix 'I2S3_CH1 DL1_CH1' 1
    tinymix 'I2S3_CH2 DL1_CH2' 1
    tinymix 'I2S3_HD_Mux' 'Low_Jitter'

    tinymix  'aw_dev_0_prof'    'Receiver'
    tinymix  'aw_dev_0_switch'  'Enable'
    tinymix  'aw_dev_1_prof'    'Receiver'
    tinymix  'aw_dev_1_switch'  'Disable'

    sleep 0.2
}

function disable_receiver
{
    echo "disabling receiver"
    tinymix 'I2S3_CH1 DL1_CH1' 0
    tinymix 'I2S3_CH2 DL1_CH2' 0
    tinymix 'I2S3_HD_Mux' 'Normal'

    tinymix 'aw_dev_0_prof' 'Music'
    tinymix 'aw_dev_0_switch' 'Enable'
    tinymix 'aw_dev_1_prof' 'Music'
    tinymix 'aw_dev_1_switch' 'Enable'

}

function enable_speaker
{
    echo "enabling speaker"
    tinymix 'I2S3_CH1 DL1_CH1' 1
    tinymix 'I2S3_CH2 DL1_CH2' 1
    tinymix 'I2S3_HD_Mux' 'Low_Jitter'

    tinymix 'aw_dev_0_prof' 'Music'
    tinymix 'aw_dev_0_switch' 'Enable'
    tinymix 'aw_dev_1_prof' 'Music'
    tinymix 'aw_dev_1_switch' 'Enable'

    sleep 0.2
}

function disable_speaker
{
    echo "disabling speaker"
    tinymix 'I2S3_CH1 DL1_CH1' 0
    tinymix 'I2S3_CH2 DL1_CH2' 0
    tinymix 'I2S3_HD_Mux' 'Normal'

}

function enable_speaker_top
{
    echo "enabling speaker top"
    tinymix 'I2S3_CH1 DL1_CH1' 1
    tinymix 'I2S3_CH2 DL1_CH2' 0
    tinymix 'I2S3_HD_Mux' 'Low_Jitter'

    tinymix 'aw_dev_0_prof' 'Music'
    tinymix 'aw_dev_0_switch' 'Enable'
    tinymix 'aw_dev_1_prof' 'Music'
    tinymix 'aw_dev_1_switch' 'Enable'

    sleep 0.2
}

function disable_speaker_top
{
    echo "disabling speaker top"
    tinymix 'I2S3_CH1 DL1_CH1' 0
    tinymix 'I2S3_CH2 DL1_CH2' 0
    tinymix 'I2S3_HD_Mux' 'Normal'


}
function enable_speaker_bot
{
    echo "enabling speaker bottom"
    tinymix 'I2S3_CH1 DL1_CH1' 0
    tinymix 'I2S3_CH2 DL1_CH2' 1
    tinymix 'I2S3_HD_Mux' 'Low_Jitter'

    tinymix 'aw_dev_0_prof' 'Music'
    tinymix 'aw_dev_0_switch' 'Enable'
    tinymix 'aw_dev_1_prof' 'Music'
    tinymix 'aw_dev_1_switch' 'Enable'

    sleep 0.2
}

function disable_speaker_bot
{
    echo "disabling speaker bottom"
    tinymix 'I2S3_CH1 DL1_CH1' 0
    tinymix 'I2S3_CH2 DL1_CH2' 0
    tinymix 'I2S3_HD_Mux' 'Normal'

}

function enable_ultrasound
{
    echo "enable ultrasound"
#    tinymix  "I2S3_CH1 DL7_CH1" "1"
#    tinymix  "I2S3_CH2 DL7_CH2" "1"

    tinymix 'I2S3_CH1 DL1_CH1' 1
    tinymix 'I2S3_CH2 DL1_CH2' 1
    tinymix 'I2S3_HD_Mux' 'Low_Jitter'
    tinymix  'aw_dev_0_prof'    'Receiver'
    tinymix  'aw_dev_0_switch'  'Enable'
    sleep 0.2
}

function disable_ultrasound
{
    echo "disable ultrasound"
#    tinymix  "I2S3_CH1 DL7_CH1" "0"
#    tinymix  "I2S3_CH2 DL7_CH2" "0"

    tinymix 'I2S3_CH1 DL1_CH1' 0
    tinymix 'I2S3_CH2 DL1_CH2' 0
    tinymix 'I2S3_HD_Mux' 'Normal'
    
    tinymix 'aw_dev_0_prof' 'Receiver'
    tinymix 'aw_dev_0_switch' 'Disable'

}


if [ "$1" = "spk" ]; then
    enable_speaker
    filename=/vendor/etc/spk.wav
    pcm_id=0
elif [ "$1" = "top-spk" ]; then
    enable_speaker_top
    filename=/vendor/etc/top_spk.wav
    pcm_id=0
elif [ "$1" = "bot-spk" ]; then
    enable_speaker_bot
    filename=/vendor/etc/bottom_spk.wav
    pcm_id=0
elif [ "$1" = "spk_hp" ]; then
    enable_speaker
    filename=/vendor/etc/spk_hp.wav
    pcm_id=0
elif [ "$1" = "top-spk_hp" ]; then
    enable_speaker_top
    filename=/vendor/etc/spk_hp.wav
    pcm_id=0
elif [ "$1" = "bot-spk_hp" ]; then
    enable_speaker_bot
    filename=/vendor/etc/bottom_spk_hp.wav
    pcm_id=0
elif [ "$1" = "rcv" ]; then
    enable_receiver
    filename=/vendor/etc/rcv.wav
    pcm_id=0
elif [ "$1" = "us" ]; then
    enable_ultrasound
    filename=/vendor/etc/ultrasound.wav
    pcm_id=0
else
    echo "Usage: playback.sh device; device: spk or spk_hp or rcv"
fi

echo "start playing"
tinyplay $filename -D 0 -d $pcm_id

if [ "$1" = "spk" ]; then
    disable_speaker
elif [ "$1" = "top-spk" ]; then
    disable_speaker_top
elif [ "$1" = "bot-spk" ]; then
    disable_speaker_bot
elif [ "$1" = "spk_hp" ]; then
    disable_speaker
elif [ "$1" = "top-spk_hp" ]; then
    disable_speaker_top
elif [ "$1" = "bot-spk_hp" ]; then
    disable_speaker_bot
elif [ "$1" = "rcv" ]; then
    disable_receiver
elif [ "$1" = "us" ]; then
    disable_ultrasound
fi

exit 0
