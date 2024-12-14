function previsoes_certas = BloomFilter(k)
    load('BF.mat', 'BF');
    load('senhas_nao_seguras_testeeeee.mat');
    load('senhas_teste_BloomFilter.mat');
    load('total_hashes_repetidos.mat', 'total_hashes_repetidos'); % Carregar hashes repetidos
   
    previsoes_certas = 0;
        for i = 1:length(senhas_nao_seguras_testeeeee)
        is_compromised = check(BF, senhas_nao_seguras_testeeeee{i}, k);
        if ~is_compromised
            previsoes_certas = previsoes_certas + 1;
        end
        end

    previsoes_errradas = 0;
    for i = 1:length(senhas_teste_BloomFilter)
        is_compromised = check(BF, senhas_teste_BloomFilter{i}, k);
        if is_compromised
            previsoes_errradas = previsoes_errradas + 1;
        end
    end

    fprintf('Número total de colisôes: %d\n', total_hashes_repetidos);
    fprintf('Percentagem de falsos negativos: %.2f%%\n', previsoes_certas / length(senhas_nao_seguras_testeeeee) * 100);
    fprintf('Percentagem de falsos positivos: %.2f%%\n', previsoes_errradas / length(senhas_teste_BloomFilter) * 100);
end
