clc,clear,

senhas_nao_seguras = readtable('unsecure_passwords.csv', 'FileType', 'text', 'Delimiter', ',', 'Encoding', 'latin1');
comprometidas = table2array(senhas_nao_seguras);
senhas_nao_seguras_teste = comprometidas(1:1000);

% Configuração do Bloom Filter
p = 0.001;  % Probabilidade de falsos positivos
m = length(comprometidas);
n = round(-(m * log(p) / (log(2))^2));
k = round(((n / m) * log(2)) + 1);
BF = inicializador(n);

% Adicionar palavras-passe comprometidas ao filtro
for i = 1:length(comprometidas)
    BF = adicionar(BF, comprometidas{i}, k);
end




previsoes_certas = 0;
disp('Verificando palavras-passe:');
for i = 1:length(senhas_nao_seguras_teste)
    is_compromised = check(BF, senhas_nao_seguras_teste{i}, k);
    if is_compromised
        previsoes_certas = previsoes_certas + 1;     
    end
end

precisao = previsoes_certas / length(senhas_nao_seguras_teste)* 100
