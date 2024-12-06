senhas_nao_seguras = readtable('passes_nao_seguras.csv', 'FileType', 'text', 'Delimiter', ',', 'Encoding', 'latin1');
senhas_nao_seguras = table2array(senhas_nao_seguras); 

senhas_seguras = readtable('passes_seguras.csv', 'FileType', 'text', 'Delimiter', ',', 'Encoding', 'latin1');
senhas_seguras = table2array(senhas_seguras); 


dados_nao_seguras = zeros(length(senhas_nao_seguras), 5);
dados_seguras = zeros(length(senhas_seguras), 5);


for i = 1:length(senhas_nao_seguras)
    senha = senhas_nao_seguras{i}; 
    dados_nao_seguras(i, :) = dados_passe(senha); 
end

for i = 1:length(senhas_seguras)
    senha = senhas_seguras{i}; 
    dados_seguras(i, :) = dados_passe(senha);
end

dados = [dados_nao_seguras; dados_seguras];

defenicao = [zeros(length(senhas_nao_seguras), 1); ones(length(senhas_seguras), 1)];


% Probabilidade
prob_segura = sum(defenicao == 1) / length(defenicao);
prob_nao_segura = 1-prob_segura;

% Probabilidade condicional
num_dados = size(dados, 2);
prob_passe_dado_seguro = sum(dados(defenicao == 1, :)) ./ sum(defenicao == 1);
prob_passe_dado_nao_seguro = sum(dados(defenicao == 0, :)) ./ sum(defenicao == 0);

% Pede ao utilizador
senha = input('Insira a senha para verificar: ', 's');

% Validações
if ~all(isstrprop(senha, 'print'))
    error('A senha contém caracteres inválidos.');
end

dados_senha = dados_passe(senha);

probabilidade_ser_segura = prod(prob_passe_dado_seguro(dados_senha == 1)) * prod(1 - prob_passe_dado_seguro(dados_senha == 0));
probabilidade_nao_segura = prod(prob_passe_dado_nao_seguro(dados_senha == 1)) * prod(1 - prob_passe_dado_nao_seguro(dados_senha == 0));

% P(classe/evidencia) = P(Evidencia/classe) * P(Classe)
posterior_segura = probabilidade_ser_segura * prob_segura;
posterior_nao_segura = probabilidade_nao_segura * prob_nao_segura;

if posterior_segura > posterior_nao_segura
    disp('A senha é segura.');
else
    disp('A senha não é segura.');
end