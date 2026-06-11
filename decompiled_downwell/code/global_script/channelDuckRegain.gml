function channelDuckRegain()
{
    emitterGain = audio_emitter_get_gain(global.emitterGunshot);
    
    if (emitterGain < 1)
        emitterGain += 0.1;
    
    if (emitterGain > 1)
        emitterGain = 1;
    
    audio_emitter_gain(global.emitterGunshot, emitterGain);
}
