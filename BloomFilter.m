clc,clear,

senhas_nao_seguras = readtable('unsecure_passwords.csv', 'FileType', 'text', 'Delimiter', ',', 'Encoding', 'latin1');
comprometidas = table2array(senhas_nao_seguras);

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

% Lista de palavras-passe para verificação
palavras_teste = {'oMx55Fr92TE', '8vq33V', 'welcome', 'password', 'unknown'};

% Verificar palavras-passe no filtro de Bloom
disp('Verificando palavras-passe:');
for i = 1:length(palavras_teste)
    is_compromised = check(BF, palavras_teste{i}, k);
    if is_compromised
        fprintf('A palavra "%s" foi corrompida.\n', palavras_teste{i});
    else
        fprintf('A palavra "%s" não foi corrompida.\n', palavras_teste{i});
    end
end
