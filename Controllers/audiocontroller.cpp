#include "audiocontroller.h"

AudioController::AudioController(QObject *parent)
    : QObject{parent}
    , m_volumeLevel (4)
    , m_mutedVolumeLevel (4)
{

}

int AudioController::volumeLevel() const
{
    return m_volumeLevel;
}

void AudioController::incrementVolume(const int &val)
{
    int newVolume = m_volumeLevel +val;
    if (newVolume <= 0)
        newVolume =0;
    if (newVolume >=100)
        newVolume = 100;

    setVolumeLevel(newVolume);
}

void AudioController::toggleMuteVolume()
{
    if (m_volumeLevel > 0){
        m_mutedVolumeLevel = m_volumeLevel;
        setVolumeLevel(0);
    } else {
        setVolumeLevel(m_mutedVolumeLevel);
    }


}

void AudioController::setVolumeLevel(int newVolumeLevel)
{
    if (m_volumeLevel == newVolumeLevel)
        return;
    m_volumeLevel = newVolumeLevel;
    emit volumeLevelChanged();
}
