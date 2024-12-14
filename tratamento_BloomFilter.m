senhas_nao_seguras = readtable('weak_passwords.csv', 'FileType', 'text', 'Delimiter', ',', 'Encoding', 'latin1');
comprometidas = table2array(senhas_nao_seguras);
senhas_nao_seguras_testeeeee = comprometidas(1:1000);

senhas_teste_BloomFilter = readtable('new_passwords_not_in_existing.csv', 'FileType', 'text', 'Delimiter', ',', 'Encoding', 'latin1');
senhas_teste_BloomFilter = table2array(senhas_teste_BloomFilter);

% Configuração do Bloom Filter
p = 0.001;  % Probabilidade de falsos positivos
m = length(comprometidas);
save('m_value.mat', 'm');
n = round(-(m * log(p) / (log(2))^2));
%limite maximo 5
k = round(((n / m) * log(2)) + 1);
BF = inicializador(n);

total_hashes_repetidos = 0;

for i = 1:length(comprometidas)
    [BF, hash_repetidos] = adicionar(BF, comprometidas{i}, k);
    total_hashes_repetidos = total_hashes_repetidos + hash_repetidos;
end
save('total_hashes_repetidos.mat', 'total_hashes_repetidos');
save('BF.mat', 'BF');
save('senhas_nao_seguras_testeeeee.mat', 'senhas_nao_seguras_testeeeee');
save('senhas_teste_BloomFilter.mat', 'senhas_teste_BloomFilter');

