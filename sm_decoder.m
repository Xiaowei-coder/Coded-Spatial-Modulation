function [re_coded_spat, re_signal_cons]=sm_decoder(received_signal,SNR,transmitted_signal_ref,encoded_seq_ref,signal_cons_ref,signal_size,spatial_size,rate)
%assuming signal constellation 4-qam and structure of coded spatial
%constellation is known.
%norm reference vector
for i=1:size(transmitted_signal_ref,1)
    norm_ref_v(i)=norm(transmitted_signal_ref(i,:),'fro');
end
    coded_spatial_size=spatial_size/rate;
    re_coded_spat=zeros(1,coded_spatial_size*size(received_signal,1));
    re_signal_cons=zeros(1,size(received_signal,1));
    for i=1:size(received_signal,1)
        [min_value,min_arg]= min(SNR*(norm_ref_v.^2)-2*real(conj(received_signal(i,:))*(transmitted_signal_ref.')));
        re_coded_spat((i-1)*coded_spatial_size+1:i*coded_spatial_size)=encoded_seq_ref((min_arg-1)*coded_spatial_size+1:min_arg*coded_spatial_size);
        re_signal_cons((i-1)*signal_size+1:i*signal_size)= signal_cons_ref((min_arg-1)*signal_size+1:min_arg*signal_size);
    end
end

    %NOTE: doesn't recover spatial constellation accordingly 
