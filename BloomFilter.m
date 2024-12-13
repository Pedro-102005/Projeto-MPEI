function previsoes_certas = BloomFilter(k)
    load('BF.mat', 'BF');
    load('senhas_nao_seguras_testeeeee.mat');
   
    previsoes_certas = 0;
    disp('Verificando palavras-passe:');
    
    for i = 1:length(senhas_nao_seguras_testeeeee)
        is_compromised = check(BF, senhas_nao_seguras_testeeeee{i}, k);
        if is_compromised
            previsoes_certas = previsoes_certas + 1;
        end
    end
    
    fprintf('Total de palavras-passe comprometidas detectadas: %d\n', previsoes_certas);
end
