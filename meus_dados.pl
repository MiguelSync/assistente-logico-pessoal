:- encoding(utf8).
:- discontiguous gosta/2.
% =====================================================================
%  meus_dados.pl · Assistente Lógico Pessoal · LPP
%  Base de conhecimento pessoal do Miguel.
%  Átomos em minúsculas, sem acento e sem espaço (ex.: gerencia_de_projetos).
%  Sem dados sensíveis: nada de CPF, endereço, telefone, saúde, etc.
% =====================================================================

% ---------- ETAPA 2 · FATOS ----------

% Quem sou eu
eu(miguel).
curso(sistemas_de_informacao).
cidade(rio_do_sul).

% Dias e turnos da semana (não altere)
dia(segunda).  dia(terca).  dia(quarta).  dia(quinta).  dia(sexta).  dia(sabado).
turno(manha).  turno(tarde).  turno(noite).

% Disciplinas que curso neste semestre: cursa(Disciplina, Dia, Turno)
cursa(lpp, segunda, noite).
cursa(redes_de_computadores, terca, noite).
cursa(plataformas_moveis, quarta, noite).
cursa(gerencia_de_projetos, quinta, noite).
cursa(programacao_web_2, sexta, noite).

% Outros compromissos: compromisso(Dia, Turno, Atividade)
compromisso(segunda, manha, trabalho_cro).
compromisso(segunda, manha, academia_meio_dia).
compromisso(segunda, tarde, trabalho_cro).
compromisso(segunda, noite, faculdade).
compromisso(terca, manha, trabalho_cro).
compromisso(terca, manha, academia_meio_dia).
compromisso(terca, tarde, trabalho_cro).
compromisso(terca, noite, faculdade).
compromisso(quarta, manha, trabalho_cro).
compromisso(quarta, manha, academia_meio_dia).
compromisso(quarta, tarde, trabalho_cro).
compromisso(quarta, noite, faculdade).
compromisso(quinta, manha, trabalho_cro).
compromisso(quinta, manha, academia_meio_dia).
compromisso(quinta, tarde, trabalho_cro).
compromisso(quinta, noite, faculdade).
compromisso(sexta, manha, trabalho_cro).
compromisso(sexta, manha, academia_meio_dia).
compromisso(sexta, tarde, trabalho_cro).
compromisso(sexta, noite, faculdade).
compromisso(sabado, manha, impressao_3d).

% Linguagens que sei: sabe(Linguagem, Nivel)   Nivel: basico | intermediario | avancado
sabe(html, avancado).
sabe(css, avancado).
sabe(javascript, avancado).
sabe(php, intermediario).
sabe(liquid, intermediario).
sabe(python, basico).

% Do que eu gosto: gosta(Categoria, Item)
gosta(jogo, league_of_legends).
gosta(campeao, yone).
gosta(campeao, irelia).
gosta(hobby, impressao_3d).
gosta(hobby, front_end).
gosta(impressora, bambu_lab_a1).

% ---------- ETAPA 3 · REGRAS ----------

% R1 · Estou ocupado se tenho aula OU compromisso (duas cláusulas = OU)
ocupado(Dia, Turno) :- cursa(_, Dia, Turno).
ocupado(Dia, Turno) :- compromisso(Dia, Turno, _).

% R2 · Estou livre se NÃO for possível provar que estou ocupado
livre(Dia, Turno) :- dia(Dia), turno(Turno), \+ ocupado(Dia, Turno).

% R3 · O que faço em um dia e turno (aula ou compromisso)
o_que_faco(Dia, Turno, Atividade) :- cursa(Atividade, Dia, Turno).
o_que_faco(Dia, Turno, Atividade) :- compromisso(Dia, Turno, Atividade).

% R4 · Posso ensinar uma linguagem se sei em nível intermediário ou avançado
pode_ensinar(Linguagem) :- sabe(Linguagem, Nivel), member(Nivel, [intermediario, avancado]).

% R5 · Dia cheio: dois turnos ou mais ocupados
dia_cheio(Dia) :- dia(Dia), findall(T, ocupado(Dia, T), Ts), sort(Ts, Unicos), length(Unicos, N), N >= 2.

% R6 · MINHA REGRA: noite de ranqueada
% ranqueada(Dia, Campeao) é verdade quando:
%   1) livre(Dia, noite)               -> a noite desse dia está livre (sem aula nem compromisso);
%   2) gosta(jogo, league_of_legends)  -> eu jogo League of Legends;
%   3) gosta(campeao, Campeao)         -> o campeão é um dos meus mains.
% Resultado: em quais noites dá para jogar uma ranqueada e com qual main.
ranqueada(Dia, Campeao) :-
    livre(Dia, noite),
    gosta(jogo, league_of_legends),
    gosta(campeao, Campeao).
