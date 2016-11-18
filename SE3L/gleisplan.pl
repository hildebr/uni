%              :___a1___11___g1________31_______________________z5________
%                       /              /
%                     12_____g2_______32_        _____a2____:
%                     /                  \      /
%                   13_______g3__________33_34_51_____a3____:
%                   /                        \
% _z1_21_______15_14_________g4______________35_36____a4____:
%      \       /                                 \
% _z2__22_23_16______________g5__________________37_38____52_____z3_______
%          \                                         \    /
%  :__a10__24__25____________g6__________________41__39__53______z4_______
%               \                                /
%                26__________g7______________43_42______a5________:
%                 \                          /
%                  27________g8____________44   ________a6________:
%                   \                      /   /
%         :___a11___28_______g9__________45__54_55______a7________:
%                                                \
%                                                 56____a8________:
%                                                  \
%                                                   \___a9________:

weiche(w11,a1,g1,g).       weiche(w11,w1112,g1,a).
weiche(w12,w1213,w1112,g). weiche(w12,w1213,g2,a).
weiche(w13,w1314,w1213,g). weiche(w13,w1314,g3,a).
weiche(w14,w1415,g4,g).    weiche(w14,w1415,w1314,a).
weiche(w15,w1521,w1415,g). weiche(w15,w1516,w1415,a).
weiche(w16,w1623,g5,g).    weiche(w16,w1623,w1516,a).

weiche(w21,z1,w1521,g).    weiche(w21,z1,w2122,a).
weiche(w22,z2,w2223,g).    weiche(w22,w2122,w2223,a).
weiche(w23,w2223,w1623,g). weiche(w23,w2223,w2324,a).
weiche(w24,a10,w2425,g).   weiche(w24,w2324,w2425,a).
weiche(w25,w2425,g6,g).    weiche(w25,w2425,w2526,a).
weiche(w26,w2526,w2627,g). weiche(w26,w2526,g7,a).          %%% Korrektur
weiche(w27,w2627,w2728,g). weiche(w27,w2627,g8,a).
weiche(w28,a11,g9,g).      weiche(w28,w2728,g9,a).

weiche(w31,g1,z5,g).       weiche(w31,w3132,z5,a).
weiche(w32,g2,w3233,g).    weiche(w32,g2,w3132,a).
weiche(w33,g3,w3334,g).    weiche(w33,w3233,w3334,a).
weiche(w34,w3334,w3451,g). weiche(w34,w3334,w3435,a).
weiche(w35,w3435,w3536,a). weiche(w35,g4,w3536,g).
weiche(w36,w3536,a4,g).    weiche(w36,w3536,w3637,a).
weiche(w37,g5,w3738,g).    weiche(w37,w3637,w3738,a).
weiche(w38,w3738,w3852,g). weiche(w38,w3738,w3839,a).
weiche(w39,w3941,w3953,g). weiche(w39,w3839,w3953,a).

weiche(w41,g6,w3941,g).    weiche(w41,w4142,w3941,a).
weiche(w42,w4243,a5,g).    weiche(w42,w4243,w4142,a).
weiche(w43,g7,w4243,g).    weiche(w43,w4344,w4243,a).
weiche(w44,w4445,w4344,g). weiche(w44,g8,w4344,a).
weiche(w45,g9,w4554,g).    weiche(w45,g9,w4445,a).

weiche(w51,w3451,a3,g).    weiche(w51,w3451,a2,a).
weiche(w52,w3852,z3,g).    weiche(w52,w5253,z3,a).
weiche(w53,w3953,z4,g).    weiche(w53,w3953,w5253,a).
weiche(w54,w4554,w5455,g). weiche(w54,w4554,a6,a).
weiche(w55,w5455,a7,g).    weiche(w55,w5455,w5556,a).
weiche(w56,w5556,a9,g).    weiche(w56,w5556,a8,a).

gleis(g1,150,b).
gleis(g2,150,b).
gleis(g3,200,r).
gleis(g4,250,b).
gleis(g5,290,b).
gleis(g6,300,b).
gleis(g7,260,b).
gleis(g8,210,r).
gleis(g9,160,r).
gleis(a1,100,a).
gleis(a2,120,a).
gleis(a3,120,a).
gleis(a4,100,a).
gleis(a5,160,a).
gleis(a6,160,a).
gleis(a7,120,a).
gleis(a8,100,a).
gleis(a9,80,a).
gleis(a10,120,a).
gleis(a11,200,a).
gleis(z1,100000,z).
gleis(z2,100000,z).
gleis(z3,100000,z).
gleis(z4,100000,z).
gleis(z5,100000,z).

einfahrt(z2,kirchstedt).
einfahrt(z3,burgdorf).
einfahrt(z5,hinterberg).
ausfahrt(z5,hinterberg).
ausfahrt(z4,burgdorf).
ausfahrt(z1,kirchstedt).
