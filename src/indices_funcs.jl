
SWI_func(G::Number, N::Number, S1::Number) = (G * (N - S1)) / ((G + N) * (N + S1))

WI1_func(G::Number, S2::Number) = (G - S2) / (G + S2)

NDVIMNDWI_func(N::Number, R::Number, G::Number, S1::Number) = ((N - R)/(N + R)) - ((G - S1)/(G + S1))

BAIS2_func(RE2::Number, RE3::Number, N2::Number, R::Number, S2::Number) = (1.0 - ((RE2 * RE3 * N2) / R) ^ 0.5) * (((S2 - N2)/(S2 + N2) ^ 0.5) + 1.0)

PSRI_func(R::Number, B::Number, RE2::Number) = (R - B)/RE2

MGRVI_func(G::Number, R::Number) = (G ^ 2.0 - R ^ 2.0) / (G ^ 2.0 + R ^ 2.0)

SR_func(N::Number, R::Number) = N/R

MBI_func(S1::Number, S2::Number, N::Number) = ((S1 - S2 - N)/(S1 + S2 + N)) + 0.5

WRI_func(G::Number, R::Number, N::Number, S1::Number) = (G + R)/(N + S1)

NDISIg_func(T::Number, G::Number, N::Number, S1::Number) = (T - (G + N + S1) / 3.0)/(T + (G + N + S1) / 3.0)

IRECI_func(RE3::Number, R::Number, RE1::Number, RE2::Number) = (RE3 - R) / (RE1 / RE2)

MTVI2_func(N::Number, G::Number, R::Number) = (1.5 * (1.2 * (N - G) - 2.5 * (R - G))) / ((((2.0 * N + 1) ^ 2) - (6.0 * N - 5 * (R ^ 0.5)) - 0.5) ^ 0.5)

VIG_func(G::Number, R::Number) = (G - R) / (G + R)

TCARIOSAVI705_func(RE2::Number, RE1::Number, G::Number) = (3 * ((RE2 - RE1) - 0.2 * (RE2 - G) * (RE2 / RE1))) / (1.16 * (RE2 - RE1) / (RE2 + RE1 + 0.16))

BaI_func(R::Number, S1::Number, N::Number) = R + S1 - N

CCI_func(G1::Number, R::Number) = (G1 - R)/(G1 + R)

NRFIr_func(R::Number, S2::Number) = (R - S2) / (R + S2)

NBRplus_func(S2::Number, N2::Number, G::Number, B::Number) = (S2 - N2 - G - B)/(S2 + N2 + G + B)

NDBI_func(S1::Number, N::Number) = (S1 - N) / (S1 + N)

NDSInw_func(N::Number, S1::Number, beta::Number) = (N - S1 - beta)/(N + S1)

DSWI3_func(S1::Number, R::Number) = S1/R

NIRv_func(N::Number, R::Number) = ((N - R) / (N + R)) * N

GEMI_func(N::Number, R::Number) = ((2.0*((N ^ 2.0)-(R ^ 2.0)) + 1.5*N + 0.5*R)/(N + R + 0.5))*(1.0 - 0.25*((2.0 * ((N ^ 2.0) - (R ^ 2)) + 1.5 * N + 0.5 * R)/(N + R + 0.5)))-((R - 0.125)/(1 - R))

FCVI_func(N::Number, R::Number, G::Number, B::Number) = N - ((R + G + B)/3.0)

VHVVR_func(VH::Number, VV::Number) = VH/VV

GCC_func(G::Number, R::Number, B::Number) = G / (R + G + B)

WDRVI_func(alpha::Number, N::Number, R::Number) = (alpha * N - R) / (alpha * N + R)

ExGR_func(G::Number, R::Number, B::Number) = (2.0 * G - R - B) - (1.3 * R - G)

DSI_func(S1::Number, N::Number) = S1/N

ExG_func(G::Number, R::Number, B::Number) = 2 * G - R - B

GSAVI_func(L::Number, N::Number, G::Number) = (1.0 + L) * (N - G) / (N + G + L)

ATSAVI_func(sla::Number, N::Number, R::Number, slb::Number) = sla * (N - sla * R - slb) / (sla * N + R - sla * slb + 0.08 * (1 + sla ^ 2.0))

MLSWI27_func(N::Number, S2::Number) = (1.0 - N - S2)/(1.0 - N + S2)

SeLI_func(N2::Number, RE1::Number) = (N2 - RE1) / (N2 + RE1)

NDPI_func(N::Number, alpha::Number, R::Number, S1::Number) = (N - (alpha * R + (1.0 - alpha) * S1))/(N + (alpha * R + (1.0 - alpha) * S1))

NDGI_func(lambdaN::Number, lambdaR::Number, lambdaG::Number, G::Number, N::Number, R::Number) = (((lambdaN - lambdaR)/(lambdaN - lambdaG)) * G + (1.0 - ((lambdaN - lambdaR)/(lambdaN - lambdaG))) * N - R)/(((lambdaN - lambdaR)/(lambdaN - lambdaG)) * G + (1.0 - ((lambdaN - lambdaR)/(lambdaN - lambdaG))) * N + R)

SR2_func(N::Number, G::Number) = N/G

NGRDI_func(G::Number, R::Number) = (G - R) / (G + R)

NBR2_func(S1::Number, S2::Number) = (S1 - S2) / (S1 + S2)

NDVI705_func(RE2::Number, RE1::Number) = (RE2 - RE1) / (RE2 + RE1)

TVI_func(N::Number, R::Number) = (((N - R)/(N + R)) + 0.5) ^ 0.5

NDBaI_func(S1::Number, T::Number) = (S1 - T) / (S1 + T)

SAVIT_func(L::Number, N::Number, R::Number, T::Number) = (1.0 + L) * (N - (R * T / 10000.0)) / (N + (R * T / 10000.0) + L)

WI2_func(B::Number, S2::Number) = (B - S2) / (B + S2)

NBAI_func(S2::Number, S1::Number, G::Number) = ((S2 - S1)/G)/((S2 + S1)/G)

BI_func(S1::Number, R::Number, N::Number, B::Number) = ((S1 + R) - (N + B))/((S1 + R) + (N + B))

RDVI_func(N::Number, R::Number) = (N - R) / ((N + R) ^ 0.5)

TGI_func(R::Number, G::Number, B::Number) = - 0.5 * (190 * (R - G) - 120 * (R - B))

NRFIg_func(G::Number, S2::Number) = (G - S2) / (G + S2)

MSR_func(N::Number, R::Number) = (N / R - 1) / ((N / R + 1) ^ 0.5)

TriVI_func(N::Number, G::Number, R::Number) = 0.5 * (120 * (N - G) - 200 * (R - G))

ARI_func(G::Number, RE1::Number) = (1 / G) - (1 / RE1)

NBRSWIR_func(S2::Number, S1::Number) = (S2 - S1 - 0.02)/(S2 + S1 + 0.1)

OCVI_func(N::Number, G::Number, R::Number, cexp::Number) = (N / G) * (R / G) ^ cexp

NormG_func(G::Number, N::Number, R::Number) = G/(N + G + R)

BLFEI_func(G::Number, R::Number, S2::Number, S1::Number) = (((G+R+S2)/3.0)-S1)/(((G+R+S2)/3.0)+S1)

DVI_func(N::Number, R::Number) = N - R

MuWIR_func(B::Number, G::Number, N::Number, S2::Number, S1::Number) = -4.0 * ((B - G)/(B + G)) + 2.0 * ((G - N)/(G + N)) + 2.0 * ((G - S2)/(G + S2)) - ((G - S1)/(G + S1))

MNLI_func(L::Number, N::Number, R::Number) = (1 + L)*((N ^ 2) - R)/((N ^ 2) + R + L)

NDSoiI_func(S2::Number, G::Number) = (S2 - G)/(S2 + G)

NDWIns_func(G::Number, alpha::Number, N::Number) = (G - alpha * N)/(G + N)

RI_func(R::Number, G::Number) = (R - G)/(R + G)

SARVI_func(L::Number, N::Number, R::Number, B::Number) = (1 + L)*(N - (R - (R - B))) / (N + (R - (R - B)) + L)

kIPVI_func(kNN::Number, kNR::Number) = kNN/(kNN + kNR)

TWI_func(RE1::Number, RE2::Number, G::Number, S2::Number, B::Number, N::Number) = (2.84 * (RE1 - RE2) / (G + S2)) + ((1.25 * (G - B) - (N - B)) / (N + 1.25 * G - 0.25 * B))

MSAVI_func(N::Number, R::Number) = 0.5 * (2.0 * N + 1 - (((2 * N + 1) ^ 2) - 8 * (N - R)) ^ 0.5)

DpRVIVV_func(VH::Number, VV::Number) = (4.0 * VH)/(VV + VH)

RVI_func(RE2::Number, R::Number) = RE2 / R

MRBVI_func(R::Number, B::Number) = (R ^ 2.0 - B ^ 2.0)/(R ^ 2.0 + B ^ 2.0)

NSTv2_func(N::Number, S2::Number, T::Number) = (N-(S2+T))/(N+(S2+T))

TCI_func(RE1::Number, G::Number, R::Number) = 1.2 * (RE1 - G) - 1.5 * (R - G) * (RE1 / R) ^ 0.5

ExR_func(R::Number, G::Number) = 1.3 * R - G

CIG_func(N::Number, G::Number) = (N / G) - 1.0

NDPolI_func(VV::Number, VH::Number) = (VV - VH)/(VV + VH)

BCC_func(B::Number, R::Number, G::Number) = B / (R + G + B)

SI_func(B::Number, G::Number, R::Number) = ((1.0 - B) * (1.0 - G) * (1.0 - R)) ^ (1/3)

mSR705_func(RE2::Number, A::Number) = (RE2 - A)/(RE2 + A)

SR555_func(RE2::Number, G::Number) = RE2 / G

NBRT1_func(N::Number, S2::Number, T::Number) = (N - (S2 * T / 10000.0)) / (N + (S2 * T / 10000.0))

ANDWI_func(B::Number, G::Number, R::Number, N::Number, S1::Number, S2::Number) = (B + G + R - N - S1 - S2)/(B + G + R + N + S1 + S2)

WDVI_func(N::Number, sla::Number, R::Number) = N - sla * R

NWI_func(B::Number, N::Number, S1::Number, S2::Number) = (B - (N + S1 + S2))/(B + (N + S1 + S2))

GARI_func(N::Number, G::Number, B::Number, R::Number) = (N - (G - (B - R))) / (N - (G + (B - R)))

MCARI705_func(RE2::Number, RE1::Number, G::Number) = ((RE2 - RE1) - 0.2 * (RE2 - G)) * (RE2 / RE1)

NormNIR_func(N::Number, G::Number, R::Number) = N/(N + G + R)

SWM_func(B::Number, G::Number, N::Number, S1::Number) = (B + G)/(N + S1)

mND705_func(RE2::Number, RE1::Number, A::Number) = (RE2 - RE1)/(RE2 + RE1 - A)

SAVI_func(L::Number, N::Number, R::Number) = (1.0 + L) * (N - R) / (N + R + L)

EVI2_func(g::Number, N::Number, R::Number, L::Number) = g * (N - R) / (N + 2.4 * R + L)

DPDD_func(VV::Number, VH::Number) = (VV + VH)/2.0 ^ 0.5

NIRvP_func(N::Number, R::Number, PAR::Number) = ((N - R) / (N + R)) * N * PAR

VHVVD_func(VH::Number, VV::Number) = VH - VV

SR3_func(N2::Number, G::Number, RE1::Number) = N2/(G * RE1)

NBR_func(N::Number, S2::Number) = (N - S2) / (N + S2)

EMBI_func(S1::Number, S2::Number, N::Number, G::Number) = ((((S1 - S2 - N)/(S1 + S2 + N)) + 0.5) - ((G - S1)/(G + S1)) - 0.5)/((((S1 - S2 - N)/(S1 + S2 + N)) + 0.5) + ((G - S1)/(G + S1)) + 1.5)

GDVI_func(N::Number, nexp::Number, R::Number) = ((N ^ nexp) - (R ^ nexp)) / ((N ^ nexp) + (R ^ nexp))

MCARIOSAVI_func(RE1::Number, R::Number, G::Number, N::Number) = (((RE1 - R) - 0.2 * (RE1 - G)) * (RE1 / R)) / (1.16 * (N - R) / (N + R + 0.16))

EBI_func(R::Number, G::Number, B::Number, epsilon::Number) = (R + G + B)/((G/B) * (R - B + epsilon))

AWEInsh_func(G::Number, S1::Number, N::Number, S2::Number) = 4.0 * (G - S1) - 0.25 * N + 2.75 * S2

NDYI_func(G::Number, B::Number) = (G - B) / (G + B)

RCC_func(R::Number, G::Number, B::Number) = R / (R + G + B)

ARVI_func(N::Number, R::Number, gamma::Number, B::Number) = (N - (R - gamma * (R - B))) / (N + (R - gamma * (R - B)))

IPVI_func(N::Number, R::Number) = N/(N + R)

NDSIWV_func(G::Number, Y::Number) = (G - Y)/(G + Y)

DSWI4_func(G::Number, R::Number) = G/R

VVVHR_func(VV::Number, VH::Number) = VV/VH

kNDVI_func(kNN::Number, kNR::Number) = (kNN - kNR)/(kNN + kNR)

GOSAVI_func(N::Number, G::Number) = (N - G) / (N + G + 0.16)

OSAVI_func(N::Number, R::Number) = (N - R) / (N + R + 0.16)

AFRI2100_func(N::Number, S2::Number) = (N - 0.5 * S2) / (N + 0.5 * S2)

GNDVI_func(N::Number, G::Number) = (N - G)/(N + G)

LSWI_func(N::Number, S1::Number) = (N - S1)/(N + S1)

UI_func(S2::Number, N::Number) = (S2 - N)/(S2 + N)

S2WI_func(RE1::Number, S2::Number) = (RE1 - S2)/(RE1 + S2)

VIBI_func(N::Number, R::Number, S1::Number) = ((N-R)/(N+R))/(((N-R)/(N+R)) + ((S1-N)/(S1+N)))

NSDSI1_func(S1::Number, S2::Number) = (S1-S2)/S1

VVVHS_func(VV::Number, VH::Number) = VV + VH

VI6T_func(N::Number, T::Number) = (N - T/10000.0)/(N + T/10000.0)

kVARI_func(kGG::Number, kGR::Number, kGB::Number) = (kGG - kGR) / (kGG + kGR - kGB)

BWDRVI_func(alpha::Number, N::Number, B::Number) = (alpha * N - B) / (alpha * N + B)

BAIM_func(N::Number, S2::Number) = 1.0/((0.05 - N) ^ 2.0) + ((0.2 - S2) ^ 2.0)

VDDPI_func(VV::Number, VH::Number) = (VV + VH)/VV

BIXS_func(G::Number, R::Number) = (((G^2.0)+(R^2.0))/2.0)^0.5

MCARIOSAVI705_func(RE2::Number, RE1::Number, G::Number) = (((RE2 - RE1) - 0.2 * (RE2 - G)) * (RE2 / RE1)) / (1.16 * (RE2 - RE1) / (RE2 + RE1 + 0.16))

NDSI_func(G::Number, S1::Number) = (G - S1) / (G + S1)

NDVI_func(N::Number, R::Number) = (N - R)/(N + R)

MCARI_func(RE1::Number, R::Number, G::Number) = ((RE1 - R) - 0.2 * (RE1 - G)) * (RE1 / R)

MLSWI26_func(N::Number, S1::Number) = (1.0 - N - S1)/(1.0 - N + S1)

VgNIRBI_func(G::Number, N::Number) = (G - N)/(G + N)

TCARIOSAVI_func(RE1::Number, R::Number, G::Number, N::Number) = (3 * ((RE1 - R) - 0.2 * (RE1 - G) * (RE1 / R))) / (1.16 * (N - R) / (N + R + 0.16))

AVI_func(N::Number, R::Number) = (N * (1.0 - R) * (N - R)) ^ (1/3)

NormR_func(R::Number, N::Number, G::Number) = R/(N + G + R)

VHVVP_func(VH::Number, VV::Number) = VH * VV

NSDS_func(S1::Number, S2::Number) = (S1 - S2)/(S1 + S2)

NDSWIR_func(N::Number, S1::Number) = (N - S1)/(N + S1)

REDSI_func(RE3::Number, R::Number, RE1::Number) = ((705.0 - 665.0) * (RE3 - R) - (783.0 - 665.0) * (RE1 - R)) / (2.0 * R)

DBI_func(B::Number, T1::Number, N::Number, R::Number) = ((B - T1)/(B + T1)) - ((N - R)/(N + R))

ND705_func(RE2::Number, RE1::Number) = (RE2 - RE1)/(RE2 + RE1)

MNDWI_func(G::Number, S1::Number) = (G - S1) / (G + S1)

RGBVI_func(G::Number, B::Number, R::Number) = (G ^ 2.0 - B * R)/(G ^ 2.0 + B * R)

MSI_func(S1::Number, N::Number) = S1/N

RGRI_func(R::Number, G::Number) = R/G

GRVI_func(N::Number, G::Number) = N/G

VARI_func(G::Number, R::Number, B::Number) = (G - R) / (G + R - B)

NMDI_func(N::Number, S1::Number, S2::Number) = (N - (S1 - S2))/(N + (S1 - S2))

RENDVI_func(RE2::Number, RE1::Number) = (RE2 - RE1)/(RE2 + RE1)

NSDSI2_func(S1::Number, S2::Number) = (S1-S2)/S2

TCARI_func(RE1::Number, R::Number, G::Number) = 3 * ((RE1 - R) - 0.2 * (RE1 - G) * (RE1 / R))

kEVI_func(g::Number, kNN::Number, kNR::Number, C1::Number, C2::Number, kNB::Number, kNL::Number) = g * (kNN - kNR) / (kNN + C1 * kNR - C2 * kNB + kNL)

ARI2_func(N::Number, G::Number, RE1::Number) = N * ((1 / G) - (1 / RE1))

GM1_func(RE2::Number, G::Number) = RE2/G

SLAVI_func(N::Number, R::Number, S2::Number) = N/(R + S2)

GVMI_func(N::Number, S2::Number) = ((N + 0.1) - (S2 + 0.02)) / ((N + 0.1) + (S2 + 0.02))

NBSIMS_func(G::Number, R::Number, N::Number, B::Number, S2::Number, S1::Number) = 0.36 * (G + R + N) - (((B + S2)/G) + S1)

NBLIOLI_func(R::Number, T1::Number) = (R - T1)/(R + T1)

AWEIsh_func(B::Number, G::Number, N::Number, S1::Number, S2::Number) = B + 2.5 * G - 1.5 * (N + S1) - 0.25 * S2

RFDI_func(HH::Number, HV::Number) = (HH - HV)/(HH + HV)

SIPI_func(N::Number, A::Number, R::Number) = (N - A) / (N - R)

DpRVIHH_func(HV::Number, HH::Number) = (4.0 * HV)/(HH + HV)

NDISImndwi_func(T::Number, G::Number, S1::Number, N::Number) = (T - (((G - S1)/(G + S1)) + N + S1) / 3.0)/(T + (((G - S1)/(G + S1)) + N + S1) / 3.0)

MBWI_func(omega::Number, G::Number, R::Number, N::Number, S1::Number, S2::Number) = (omega * G) - R - N - S1 - S2

GM2_func(RE2::Number, RE1::Number) = RE2/RE1

VVVHD_func(VV::Number, VH::Number) = VV - VH

VrNIRBI_func(R::Number, N::Number) = (R - N)/(R + N)

SEVI_func(N::Number, R::Number, fdelta::Number) = (N/R) + fdelta * (1.0/R)

NSTv1_func(N::Number, S2::Number, T::Number) = ((N-S2)/(N+S2))*T

NDISIndwi_func(T::Number, G::Number, N::Number, S1::Number) = (T - (((G - N)/(G + N)) + N + S1) / 3.0)/(T + (((G - N)/(G + N)) + N + S1) / 3.0)

NDGlaI_func(G::Number, R::Number) = (G - R)/(G + R)

GBNDVI_func(N::Number, G::Number, B::Number) = (N - (G + B))/(N + (G + B))

BRBA_func(R::Number, S1::Number) = R/S1

CSI_func(N::Number, S2::Number) = N/S2

NDVIT_func(N::Number, R::Number, T::Number) = (N - (R * T / 10000.0))/(N + (R * T / 10000.0))

MNDVI_func(N::Number, S2::Number) = (N - S2)/(N + S2)

BAI_func(R::Number, N::Number) = 1.0 / ((0.1 - R) ^ 2.0 + (0.06 - N) ^ 2.0)

TRRVI_func(RE2::Number, R::Number, N::Number) = ((RE2 - R) / (RE2 + R)) / (((N - R) / (N + R)) + 1.0)

EVI_func(g::Number, N::Number, R::Number, C1::Number, C2::Number, B::Number, L::Number) = g * (N - R) / (N + C1 * R - C2 * B + L)

DBSI_func(S1::Number, G::Number, N::Number, R::Number) = ((S1 - G)/(S1 + G)) - ((N - R)/(N + R))

NDPonI_func(S1::Number, G::Number) = (S1-G)/(S1+G)

NLI_func(N::Number, R::Number) = ((N ^ 2) - R)/((N ^ 2) + R)

NDSaII_func(R::Number, S1::Number) = (R - S1) / (R + S1)

MSR705_func(RE2::Number, RE1::Number) = (RE2 / RE1 - 1) / ((RE2 / RE1 + 1) ^ 0.5)

MTVI1_func(N::Number, G::Number, R::Number) = 1.2 * (1.2 * (N - G) - 2.5 * (R - G))

IKAW_func(R::Number, B::Number) = (R - B)/(R + B)

MIRBI_func(S2::Number, S1::Number) = 10.0 * S2 - 9.8 * S1 + 2.0

CSIT_func(N::Number, S2::Number, T::Number) = N / (S2 * T / 10000.0)

TDVI_func(N::Number, R::Number) = 1.5 * ((N - R)/((N ^ 2.0 + R + 0.5) ^ 0.5))

DSWI2_func(S1::Number, G::Number) = S1/G

CIRE_func(N::Number, RE1::Number) = (N / RE1) - 1

NDISIr_func(T::Number, R::Number, N::Number, S1::Number) = (T - (R + N + S1) / 3.0)/(T + (R + N + S1) / 3.0)

NDDI_func(N::Number, R::Number, G::Number) = (((N - R)/(N + R)) - ((G - N)/(G + N)))/(((N - R)/(N + R)) + ((G - N)/(G + N)))

NDREI_func(N::Number, RE1::Number) = (N - RE1) / (N + RE1)

NDTI_func(R::Number, G::Number) = (R-G)/(R+G)

QpRVI_func(HV::Number, HH::Number, VV::Number) = (8.0 * HV)/(HH + VV + 2.0 * HV)

DSWI1_func(N::Number, S1::Number) = N/S1

EBBI_func(S1::Number, N::Number, T::Number) = (S1 - N) / (10.0 * ((S1 + T) ^ 0.5))

MCARI1_func(N::Number, R::Number, G::Number) = 1.2 * (2.5 * (N - R) - 1.3 * (N - G))

BNDVI_func(N::Number, B::Number) = (N - B)/(N + B)

NDSII_func(G::Number, N::Number) = (G - N)/(G + N)

NIRvH2_func(N::Number, R::Number, k::Number, lambdaN::Number, lambdaR::Number) = N - R - k * (lambdaN - lambdaR)

NBRT2_func(N::Number, T::Number, S2::Number) = ((N / (T / 10000.0)) - S2) / ((N / (T / 10000.0)) + S2)

DVIplus_func(lambdaN::Number, lambdaR::Number, lambdaG::Number, G::Number, N::Number, R::Number) = ((lambdaN - lambdaR)/(lambdaN - lambdaG)) * G + (1.0 - ((lambdaN - lambdaR)/(lambdaN - lambdaG))) * N - R

CVI_func(N::Number, R::Number, G::Number) = (N * R) / (G ^ 2.0)

RI4XS_func(R::Number, G::Number) = (R^2.0)/(G^4.0)

kRVI_func(kNN::Number, kNR::Number) = kNN / kNR

AFRI1600_func(N::Number, S1::Number) = (N - 0.66 * S1) / (N + 0.66 * S1)

SR705_func(RE2::Number, RE1::Number) = RE2 / RE1

IBI_func(S1::Number, N::Number, R::Number, L::Number, G::Number) = (((S1-N)/(S1+N))-(((N-R)*(1.0+L)/(N+R+L))+((G-S1)/(G+S1)))/2.0)/(((S1-N)/(S1+N))+(((N-R)*(1.0+L)/(N+R+L))+((G-S1)/(G+S1)))/2.0)

VARI700_func(RE1::Number, R::Number, B::Number) = (RE1 - 1.7 * R + 0.7 * B) / (RE1 + 1.3 * R - 1.3 * B)

NBLI_func(R::Number, T::Number) = (R - T)/(R + T)

NDII_func(N::Number, S1::Number) = (N - S1)/(N + S1)

S2REP_func(RE3::Number, R::Number, RE1::Number, RE2::Number) = 705.0 + 35.0 * ((((RE3 + R) / 2.0) - RE1) / (RE2 - RE1))

NDMI_func(N::Number, S1::Number) = (N - S1)/(N + S1)

NBUI_func(S1::Number, N::Number, T::Number, R::Number, L::Number, G::Number) = ((S1 - N)/(10.0 * (T + S1) ^ 0.5)) - (((N - R) * (1.0 + L))/(N - R + L)) - (G - S1)/(G + S1)

GRNDVI_func(N::Number, G::Number, R::Number) = (N - (G + R))/(N + (G + R))

NBRT3_func(N::Number, T::Number, S2::Number) = ((N - (T / 10000.0)) - S2) / ((N - (T / 10000.0)) + S2)

TSAVI_func(sla::Number, N::Number, R::Number, slb::Number) = sla * (N - sla * R - slb) / (sla * N + R - sla * slb)

NDWI_func(G::Number, N::Number) = (G - N) / (G + N)

NSDSI3_func(S1::Number, S2::Number) = (S1-S2)/(S1+S2)

PISI_func(B::Number, N::Number) = 0.8192 * B - 0.5735 * N + 0.0750

MTCI_func(RE2::Number, RE1::Number, R::Number) = (RE2 - RE1) / (RE1 - R)

MCARI2_func(N::Number, R::Number, G::Number) = (1.5 * (2.5 * (N - R) - 1.3 * (N - G))) / ((((2.0 * N + 1) ^ 2) - (6.0 * N - 5 * (R ^ 0.5)) - 0.5) ^ 0.5)

GLI_func(G::Number, R::Number, B::Number) = (2.0 * G - R - B) / (2.0 * G + R + B)

VI700_func(RE1::Number, R::Number) = (RE1 - R) / (RE1 + R)

NDISIb_func(T::Number, B::Number, N::Number, S1::Number) = (T - (B + N + S1) / 3.0)/(T + (B + N + S1) / 3.0)

WI2015_func(G::Number, R::Number, N::Number, S1::Number, S2::Number) = 1.7204 + 171 * G + 3 * R - 70 * N - 45 * S1 - 71 * S2

BITM_func(B::Number, G::Number, R::Number) = (((B^2.0)+(G^2.0)+(R^2.0))/3.0)^0.5

S3_func(N::Number, R::Number, S1::Number) = (N * (R - S1)) / ((N + R) * (N + S1))

TTVI_func(RE3::Number, RE2::Number, N2::Number) = 0.5 * ((865.0 - 740.0) * (RE3 - RE2) - (N2 - RE2) * (783.0 - 740))

NDCI_func(RE1::Number, R::Number) = (RE1 - R)/(RE1 + R)

NHFD_func(RE1::Number, A::Number) = (RE1 - A) / (RE1 + A)

SAVI2_func(N::Number, R::Number, slb::Number, sla::Number) = N / (R + (slb / sla))

DSWI5_func(N::Number, G::Number, S1::Number, R::Number) = (N + G)/(S1 + R)

IAVI_func(N::Number, R::Number, gamma::Number, B::Number) = (N - (R - gamma * (B - R)))/(N + (R - gamma * (B - R)))
indices_funcs["SWI"] = SWI_func
indices_funcs["WI1"] = WI1_func
indices_funcs["NDVIMNDWI"] = NDVIMNDWI_func
indices_funcs["BAIS2"] = BAIS2_func
indices_funcs["PSRI"] = PSRI_func
indices_funcs["MGRVI"] = MGRVI_func
indices_funcs["SR"] = SR_func
indices_funcs["MBI"] = MBI_func
indices_funcs["WRI"] = WRI_func
indices_funcs["NDISIg"] = NDISIg_func
indices_funcs["IRECI"] = IRECI_func
indices_funcs["MTVI2"] = MTVI2_func
indices_funcs["VIG"] = VIG_func
indices_funcs["TCARIOSAVI705"] = TCARIOSAVI705_func
indices_funcs["BaI"] = BaI_func
indices_funcs["CCI"] = CCI_func
indices_funcs["NRFIr"] = NRFIr_func
indices_funcs["NBRplus"] = NBRplus_func
indices_funcs["NDBI"] = NDBI_func
indices_funcs["NDSInw"] = NDSInw_func
indices_funcs["DSWI3"] = DSWI3_func
indices_funcs["NIRv"] = NIRv_func
indices_funcs["GEMI"] = GEMI_func
indices_funcs["FCVI"] = FCVI_func
indices_funcs["VHVVR"] = VHVVR_func
indices_funcs["GCC"] = GCC_func
indices_funcs["WDRVI"] = WDRVI_func
indices_funcs["ExGR"] = ExGR_func
indices_funcs["DSI"] = DSI_func
indices_funcs["ExG"] = ExG_func
indices_funcs["GSAVI"] = GSAVI_func
indices_funcs["ATSAVI"] = ATSAVI_func
indices_funcs["MLSWI27"] = MLSWI27_func
indices_funcs["SeLI"] = SeLI_func
indices_funcs["NDPI"] = NDPI_func
indices_funcs["NDGI"] = NDGI_func
indices_funcs["SR2"] = SR2_func
indices_funcs["NGRDI"] = NGRDI_func
indices_funcs["NBR2"] = NBR2_func
indices_funcs["NDVI705"] = NDVI705_func
indices_funcs["TVI"] = TVI_func
indices_funcs["NDBaI"] = NDBaI_func
indices_funcs["SAVIT"] = SAVIT_func
indices_funcs["WI2"] = WI2_func
indices_funcs["NBAI"] = NBAI_func
indices_funcs["BI"] = BI_func
indices_funcs["RDVI"] = RDVI_func
indices_funcs["TGI"] = TGI_func
indices_funcs["NRFIg"] = NRFIg_func
indices_funcs["MSR"] = MSR_func
indices_funcs["TriVI"] = TriVI_func
indices_funcs["ARI"] = ARI_func
indices_funcs["NBRSWIR"] = NBRSWIR_func
indices_funcs["OCVI"] = OCVI_func
indices_funcs["NormG"] = NormG_func
indices_funcs["BLFEI"] = BLFEI_func
indices_funcs["DVI"] = DVI_func
indices_funcs["MuWIR"] = MuWIR_func
indices_funcs["MNLI"] = MNLI_func
indices_funcs["NDSoI"] = NDSoiI_func
indices_funcs["NDWIns"] = NDWIns_func
indices_funcs["RI"] = RI_func
indices_funcs["SARVI"] = SARVI_func
indices_funcs["kIPVI"] = kIPVI_func
indices_funcs["TWI"] = TWI_func
indices_funcs["MSAVI"] = MSAVI_func
indices_funcs["DpRVIVV"] = DpRVIVV_func
indices_funcs["RVI"] = RVI_func
indices_funcs["MRBVI"] = MRBVI_func
indices_funcs["NSTv2"] = NSTv2_func
indices_funcs["TCI"] = TCI_func
indices_funcs["ExR"] = ExR_func
indices_funcs["CIG"] = CIG_func
indices_funcs["NDPolI"] = NDPolI_func
indices_funcs["BCC"] = BCC_func
indices_funcs["SI"] = SI_func
indices_funcs["mSR705"] = mSR705_func
indices_funcs["SR555"] = SR555_func
indices_funcs["NBRT1"] = NBRT1_func
indices_funcs["ANDWI"] = ANDWI_func
indices_funcs["WDVI"] = WDVI_func
indices_funcs["NWI"] = NWI_func
indices_funcs["GARI"] = GARI_func
indices_funcs["MCARI705"] = MCARI705_func
indices_funcs["NormNIR"] = NormNIR_func
indices_funcs["SWM"] = SWM_func
indices_funcs["mND705"] = mND705_func
indices_funcs["SAVI"] = SAVI_func
indices_funcs["EVI2"] = EVI2_func
indices_funcs["DPDD"] = DPDD_func
indices_funcs["NIRvP"] = NIRvP_func
indices_funcs["VHVVD"] = VHVVD_func
indices_funcs["SR3"] = SR3_func
indices_funcs["NBR"] = NBR_func
indices_funcs["EMBI"] = EMBI_func
indices_funcs["GDVI"] = GDVI_func
indices_funcs["MCARIOSAVI"] = MCARIOSAVI_func
indices_funcs["EBI"] = EBI_func
indices_funcs["AWEInsh"] = AWEInsh_func
indices_funcs["NDYI"] = NDYI_func
indices_funcs["RCC"] = RCC_func
indices_funcs["ARVI"] = ARVI_func
indices_funcs["IPVI"] = IPVI_func
indices_funcs["NDSIWV"] = NDSIWV_func
indices_funcs["DSWI4"] = DSWI4_func
indices_funcs["VVVHR"] = VVVHR_func
indices_funcs["kNDVI"] = kNDVI_func
indices_funcs["GOSAVI"] = GOSAVI_func
indices_funcs["OSAVI"] = OSAVI_func
indices_funcs["AFRI2100"] = AFRI2100_func
indices_funcs["GNDVI"] = GNDVI_func
indices_funcs["LSWI"] = LSWI_func
indices_funcs["UI"] = UI_func
indices_funcs["S2WI"] = S2WI_func
indices_funcs["VIBI"] = VIBI_func
indices_funcs["NSDSI1"] = NSDSI1_func
indices_funcs["VVVHS"] = VVVHS_func
indices_funcs["VI6T"] = VI6T_func
indices_funcs["kVARI"] = kVARI_func
indices_funcs["BWDRVI"] = BWDRVI_func
indices_funcs["BAIM"] = BAIM_func
indices_funcs["VDDPI"] = VDDPI_func
indices_funcs["BIXS"] = BIXS_func
indices_funcs["MCARIOSAVI705"] = MCARIOSAVI705_func
indices_funcs["NDSI"] = NDSI_func
indices_funcs["NDVI"] = NDVI_func
indices_funcs["MCARI"] = MCARI_func
indices_funcs["MLSWI26"] = MLSWI26_func
indices_funcs["VgNIRBI"] = VgNIRBI_func
indices_funcs["TCARIOSAVI"] = TCARIOSAVI_func
indices_funcs["AVI"] = AVI_func
indices_funcs["NormR"] = NormR_func
indices_funcs["VHVVP"] = VHVVP_func
indices_funcs["NSDS"] = NSDS_func
indices_funcs["NDSWIR"] = NDSWIR_func
indices_funcs["REDSI"] = REDSI_func
indices_funcs["DBI"] = DBI_func
indices_funcs["ND705"] = ND705_func
indices_funcs["MNDWI"] = MNDWI_func
indices_funcs["RGBVI"] = RGBVI_func
indices_funcs["MSI"] = MSI_func
indices_funcs["RGRI"] = RGRI_func
indices_funcs["GRVI"] = GRVI_func
indices_funcs["VARI"] = VARI_func
indices_funcs["NMDI"] = NMDI_func
indices_funcs["RENDVI"] = RENDVI_func
indices_funcs["NSDSI2"] = NSDSI2_func
indices_funcs["TCARI"] = TCARI_func
indices_funcs["kEVI"] = kEVI_func
indices_funcs["ARI2"] = ARI2_func
indices_funcs["GM1"] = GM1_func
indices_funcs["SLAVI"] = SLAVI_func
indices_funcs["GVMI"] = GVMI_func
indices_funcs["NBSIMS"] = NBSIMS_func
indices_funcs["NBLIOLI"] = NBLIOLI_func
indices_funcs["AWEIsh"] = AWEIsh_func
indices_funcs["RFDI"] = RFDI_func
indices_funcs["SIPI"] = SIPI_func
indices_funcs["DpRVIHH"] = DpRVIHH_func
indices_funcs["NDISImndwi"] = NDISImndwi_func
indices_funcs["MBWI"] = MBWI_func
indices_funcs["GM2"] = GM2_func
indices_funcs["VVVHD"] = VVVHD_func
indices_funcs["VrNIRBI"] = VrNIRBI_func
indices_funcs["SEVI"] = SEVI_func
indices_funcs["NSTv1"] = NSTv1_func
indices_funcs["NDISIndwi"] = NDISIndwi_func
indices_funcs["NDGlaI"] = NDGlaI_func
indices_funcs["GBNDVI"] = GBNDVI_func
indices_funcs["BRBA"] = BRBA_func
indices_funcs["CSI"] = CSI_func
indices_funcs["NDVIT"] = NDVIT_func
indices_funcs["MNDVI"] = MNDVI_func
indices_funcs["BAI"] = BAI_func
indices_funcs["TRRVI"] = TRRVI_func
indices_funcs["EVI"] = EVI_func
indices_funcs["DBSI"] = DBSI_func
indices_funcs["NDPonI"] = NDPonI_func
indices_funcs["NLI"] = NLI_func
indices_funcs["NDSaII"] = NDSaII_func
indices_funcs["MSR705"] = MSR705_func
indices_funcs["MTVI1"] = MTVI1_func
indices_funcs["IKAW"] = IKAW_func
indices_funcs["MIRBI"] = MIRBI_func
indices_funcs["CSIT"] = CSIT_func
indices_funcs["TDVI"] = TDVI_func
indices_funcs["DSWI2"] = DSWI2_func
indices_funcs["CIRE"] = CIRE_func
indices_funcs["NDISIr"] = NDISIr_func
indices_funcs["NDDI"] = NDDI_func
indices_funcs["NDREI"] = NDREI_func
indices_funcs["NDTI"] = NDTI_func
indices_funcs["QpRVI"] = QpRVI_func
indices_funcs["DSWI1"] = DSWI1_func
indices_funcs["EBBI"] = EBBI_func
indices_funcs["MCARI1"] = MCARI1_func
indices_funcs["BNDVI"] = BNDVI_func
indices_funcs["NDSII"] = NDSII_func
indices_funcs["NIRvH2"] = NIRvH2_func
indices_funcs["NBRT2"] = NBRT2_func
indices_funcs["DVIplus"] = DVIplus_func
indices_funcs["CVI"] = CVI_func
indices_funcs["RI4XS"] = RI4XS_func
indices_funcs["kRVI"] = kRVI_func
indices_funcs["AFRI1600"] = AFRI1600_func
indices_funcs["SR705"] = SR705_func
indices_funcs["IBI"] = IBI_func
indices_funcs["VARI700"] = VARI700_func
indices_funcs["NBLI"] = NBLI_func
indices_funcs["NDII"] = NDII_func
indices_funcs["S2REP"] = S2REP_func
indices_funcs["NDMI"] = NDMI_func
indices_funcs["NBUI"] = NBUI_func
indices_funcs["GRNDVI"] = GRNDVI_func
indices_funcs["NBRT3"] = NBRT3_func
indices_funcs["TSAVI"] = TSAVI_func
indices_funcs["NDWI"] = NDWI_func
indices_funcs["NSDSI3"] = NSDSI3_func
indices_funcs["PISI"] = PISI_func
indices_funcs["MTCI"] = MTCI_func
indices_funcs["MCARI2"] = MCARI2_func
indices_funcs["GLI"] = GLI_func
indices_funcs["VI700"] = VI700_func
indices_funcs["NDISIb"] = NDISIb_func
indices_funcs["WI2015"] = WI2015_func
indices_funcs["BITM"] = BITM_func
indices_funcs["S3"] = S3_func
indices_funcs["TTVI"] = TTVI_func
indices_funcs["NDCI"] = NDCI_func
indices_funcs["NHFD"] = NHFD_func
indices_funcs["SAVI2"] = SAVI2_func
indices_funcs["DSWI5"] = DSWI5_func
indices_funcs["IAVI"] = IAVI_func
