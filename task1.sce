drums = loadwave('DSP_2020_A3_DATA/drums.wav');
speech = loadwave('DSP_2020_A3_DATA/speech.wav');
violin = loadwave('DSP_2020_A3_DATA/violin.wav');
voice = loadwave('DSP_2020_A3_DATA/voice.wav');
all = loadwave('DSP_2020_A3_DATA/Violin_Viola_Cello_Bass.wav');

fir = loadwave('fir.wav');

function y=my_conv(f, g, filename)
    f_zeroed = cat(2, f, zeros(1, length(g)))
    g_zeroed = cat(2, g, zeros(1, length(f)))
    
    fft_f = fft(f_zeroed)
    fft_g = fft(g_zeroed)
        
    y = ifft(fft_f .* fft_g)
    
    savewave(filename, y, 44100)
endfunction

my_convolved_voice = my_conv(voice, fir, 'my_voice.wav')
my_convolved_speech = my_conv(speech(1), fir, 'my_speech.wav')
my_convolved_violin = my_conv(violin, fir, 'my_violing.wav')
my_convolved_drums = my_conv(drums, fir, 'my_drums.wav')
my_convolved_all = my_conv(all, fir, 'my_all.wav')

y = convol(voice, fir)
savewave('lib_voice.wav', y, 44100)
y = convol(drums, fir)
savewave('lib_drums.wav', y, 44100)
y = convol(speech(1), fir)
savewave('lib_speech.wav', y, 44100)
y = convol(violin, fir)
savewave('lib_violin.wav', y, 44100)
y = convol(all, fir)
savewave('lib_all.wav', y, 44100)

