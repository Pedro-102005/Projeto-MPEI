function BloomFilter_input(k)
    load('BF.mat', 'BF');
    load('ultima_palavra_teste.mat', 'senha');
    
    is_compromised = check(BF, senha, k);
    
    if is_compromised
        fprintf('Filtro de Bloom: A palavra-passe "%s" está comprometida.\n', senha);
    else
        fprintf('Filtro de Bloom: A palavra-passe "%s" não está comprometida.\n', senha);
    end
end

