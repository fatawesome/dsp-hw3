clear()

drums = loadwave('DSP_2020_A3_DATA/drums.wav');
speech = loadwave('DSP_2020_A3_DATA/speech.wav');
violin = loadwave('DSP_2020_A3_DATA/violin.wav');
voice = loadwave('DSP_2020_A3_DATA/voice.wav');
all = loadwave('DSP_2020_A3_DATA/Violin_Viola_Cello_Bass.wav');

// Lowpass:
a_low = [1.9733442497812987, ...
-0.9736948719763] // coefficients for a_1 and a_2 
b_low = [0.00008765554875401547, ...
0.00017531109750803094, ...
0.00008765554875401547] // coefficients for b_0, b_1 and b_2

// Highpass
a_high = [-0.3769782747249014, ...
-0.19680764477614976] // coefficients for a_1 and a_2
b_high = [0.40495734254626874, -0.8099146850925375, ...
0.4049573425462687] // coefficients for b_0, b_1 and b_2

function w_n=helper(as, x_n, n)
    res = 0  
    if n < 1 then
        w_n = 0
    else
        for k = 1:length(as)
            res = res + (a(k) * helper(n-k+1)) + x_n
        end
        w_n = res
    end
endfunction

function y=iir(wave, a, b, filename, num)
    w(1) = zeros(1)
    w(length(wave)) = 0
    y(1) = zeros(1)
    y(length(wave)) = 0

    for k = 1:length(wave)
        w(k) = wave(k)
        
        for i = 1:length(a)
            if (k - i) > 0 then
                w(k) = w(k) + w(k-i) * a(i)
            end
        end
        
        for j = 1:length(b)
            if (k - j + 1) > 0 then
                y(k) = y(k) + w(k - j + 1) * b(j)
            end
        end
    end

    f = figure(num);
    clf;
    plot(y)
    
    savewave(filename, y, 44100)
endfunction

iir(voice, a_low, b_low, 'task2_low.wav', 1)
iir(voice, a_high, b_high, 'task2_high.wav', 2)





