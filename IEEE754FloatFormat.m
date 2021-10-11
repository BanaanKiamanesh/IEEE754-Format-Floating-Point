clear
close all
clc

%% Vector into IEEE 754 Floating Point Format

Vector = rand(1, 5);                    % Create a Random Vector

Index = randi(length(Vector), 1, 1);    % Pick a Random Element
disp(Vector(Index))

% Memory Allocation 
IEEE754 = zeros(length(Vector), 32);

for i = 1:length(Vector)

    % Sign Bit (if positive then 0 else 1)
    SignBit = (Vector(i)<0);
    Vector(i) = abs(Vector(i));

    % Integer Part Seperation
    IntPart = floor(Vector(i));

    % Floating Part Seperation
    FloatPart = Vector(i)-IntPart;

    % Int Part to Bin
    IntPart = fliplr(dec2binvec(IntPart));
    IntPart(1) = [];
    MaxIT = 23 - length(IntPart);
    BinFloat = zeros(1, MaxIT);

    % Exponent 8 Bits
    Ebits = length(IntPart) + 127;
    Ebits = dec2binvec(Ebits);

    % Adding Zeros to the Beginning to Fill 8 bits
    Ebits = [zeros(1, 8 - length(Ebits)), fliplr(Ebits)];

    % Float Part to Bin
    for Iter = 1:MaxIT
        FloatPart = FloatPart*2;
        BinFloat(Iter) = floor(FloatPart);
        FloatPart = FloatPart-floor(FloatPart);
    end

    % Creating the Mantissa
    Mantissa = [IntPart, BinFloat];

    % Getting all the Numbers Together
    IEEE754(i, :) = [SignBit, Ebits, Mantissa];
end

disp(mat2str(IEEE754(Index, :)))

