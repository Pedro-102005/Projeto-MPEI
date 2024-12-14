function out = string2hash_aux(str, k)
    % Convert string to double array
    str = double(str);
    % Initialize hash value
    hash = 5381;
    % Compute hash for the input string
    for i = 1:length(str)
        hash = mod(hash * 33 + str(i), 2^32-1);
    end
    % Initialize output array
    out = zeros(1, k);
    % Generate k hash values
    for i = i:k
        hash = mod(hash * 33 + i, 2^32-1); 
        out(i) = hash;
    end
    
end
