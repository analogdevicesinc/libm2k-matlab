%{
This example will generate a binary counter on the first N_BITS of the
digital interface and read them back - no additional connection required
%}

%% Setup
import clib.libm2k.libm2k.*

m2k = contexts.m2kOpen();
if isempty(m2k)
    error('M2K device not found');
end

dig = m2k.getDigital();

dig.setSampleRateIn(100000);
dig.setSampleRateOut(100000);

N_BITS = 4;
DIO_OUTPUT = digital.DIO_DIRECTION.DIO_OUTPUT;

for k=1:N_BITS
    dig.setDirection(k-1,DIO_OUTPUT);
    dig.enableChannel(k-1,true);
end

out = uint16(2.^(0:N_BITS-1));

dig.setCyclic(true);
dig.push(out)

bufferIn = dig.getSamplesP(100);

bits = de2bi(bufferIn);

disp(bits(:,1:N_BITS));

contexts.contextCloseAll();

clear m2k
