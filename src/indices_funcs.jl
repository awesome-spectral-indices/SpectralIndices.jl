indices_funcs = Dict()

function SWI_func(::Type{TFL}, G, N, S1) where {TFL<:Number}
    return (G * (N - S1)) / ((G + N) * (N + S1))
end

indices_funcs["SWI"] = SWI_func

function WI1_func(::Type{TFL}, G, S2) where {TFL<:Number}
    return (G - S2) / (G + S2)
end

indices_funcs["WI1"] = WI1_func

function NDVIMNDWI_func(::Type{TFL}, N, R, G, S1) where {TFL<:Number}
    return ((N - R) / (N + R)) - ((G - S1) / (G + S1))
end

indices_funcs["NDVIMNDWI"] = NDVIMNDWI_func

function BAIS2_func(
    ::Type{TFL},
    RE2,
    RE3,
    N2,
    R,
    S2;
    const1::Number=TFL(1.0),
    const2::Number=TFL(0.5),
    const3::Number=TFL(0.5),
    const4::Number=TFL(1.0),
) where {TFL<:Number}
    return (const1 - ((RE2 * RE3 * N2) / R)^const2) *
           (((S2 - N2) / (S2 + N2)^const3) + const4)
end

indices_funcs["BAIS2"] = BAIS2_func

function PSRI_func(::Type{TFL}, R, B, RE2) where {TFL<:Number}
    return (R - B) / RE2
end

indices_funcs["PSRI"] = PSRI_func

function MGRVI_func(
    ::Type{TFL},
    G,
    R;
    const1::Number=TFL(2.0),
    const2::Number=TFL(2.0),
    const3::Number=TFL(2.0),
    const4::Number=TFL(2.0),
) where {TFL<:Number}
    return (G^const1 - R^const2) / (G^const3 + R^const4)
end

indices_funcs["MGRVI"] = MGRVI_func

function SR_func(::Type{TFL}, N, R) where {TFL<:Number}
    return N / R
end

indices_funcs["SR"] = SR_func

function MBI_func(::Type{TFL}, S1, S2, N; const1::Number=TFL(0.5)) where {TFL<:Number}
    return ((S1 - S2 - N) / (S1 + S2 + N)) + const1
end

indices_funcs["MBI"] = MBI_func

function WRI_func(::Type{TFL}, G, R, N, S1) where {TFL<:Number}
    return (G + R) / (N + S1)
end

indices_funcs["WRI"] = WRI_func

function NDISIg_func(
    ::Type{TFL}, T, G, N, S1; const1::Number=TFL(3.0), const2::Number=TFL(3.0)
) where {TFL<:Number}
    return (T - (G + N + S1) / const1) / (T + (G + N + S1) / const2)
end

indices_funcs["NDISIg"] = NDISIg_func

function IRECI_func(::Type{TFL}, RE3, R, RE1, RE2) where {TFL<:Number}
    return (RE3 - R) / (RE1 / RE2)
end

indices_funcs["IRECI"] = IRECI_func

function MTVI2_func(
    ::Type{TFL},
    N,
    G,
    R;
    const1::Number=TFL(1.5),
    const2::Number=TFL(1.2),
    const3::Number=TFL(2.5),
    const4::Number=TFL(2.0),
    const5::Number=TFL(1),
    const6::Number=TFL(2),
    const7::Number=TFL(6.0),
    const8::Number=TFL(5),
    const9::Number=TFL(0.5),
    const10::Number=TFL(0.5),
    const11::Number=TFL(0.5),
) where {TFL<:Number}
    return (const1 * (const2 * (N - G) - const3 * (R - G))) / (
        (
            ((const4 * N + const5)^const6) - (const7 * N - const8 * (R^const9)) - const10
        )^const11
    )
end

indices_funcs["MTVI2"] = MTVI2_func

function VIG_func(::Type{TFL}, G, R) where {TFL<:Number}
    return (G - R) / (G + R)
end

indices_funcs["VIG"] = VIG_func

function TCARIOSAVI705_func(
    ::Type{TFL},
    RE2,
    RE1,
    G;
    const1::Number=TFL(3),
    const2::Number=TFL(0.2),
    const3::Number=TFL(1.16),
    const4::Number=TFL(0.16),
) where {TFL<:Number}
    return (const1 * ((RE2 - RE1) - const2 * (RE2 - G) * (RE2 / RE1))) /
           (const3 * (RE2 - RE1) / (RE2 + RE1 + const4))
end

indices_funcs["TCARIOSAVI705"] = TCARIOSAVI705_func

function BaI_func(::Type{TFL}, R, S1, N) where {TFL<:Number}
    return R + S1 - N
end

indices_funcs["BaI"] = BaI_func

function CCI_func(::Type{TFL}, G1, R) where {TFL<:Number}
    return (G1 - R) / (G1 + R)
end

indices_funcs["CCI"] = CCI_func

function NRFIr_func(::Type{TFL}, R, S2) where {TFL<:Number}
    return (R - S2) / (R + S2)
end

indices_funcs["NRFIr"] = NRFIr_func

function NBRplus_func(::Type{TFL}, S2, N2, G, B) where {TFL<:Number}
    return (S2 - N2 - G - B) / (S2 + N2 + G + B)
end

indices_funcs["NBRplus"] = NBRplus_func

function NDBI_func(::Type{TFL}, S1, N) where {TFL<:Number}
    return (S1 - N) / (S1 + N)
end

indices_funcs["NDBI"] = NDBI_func

function NDSInw_func(::Type{TFL}, N, S1, beta) where {TFL<:Number}
    return (N - S1 - beta) / (N + S1)
end

indices_funcs["NDSInw"] = NDSInw_func

function DSWI3_func(::Type{TFL}, S1, R) where {TFL<:Number}
    return S1 / R
end

indices_funcs["DSWI3"] = DSWI3_func

function NIRv_func(::Type{TFL}, N, R) where {TFL<:Number}
    return ((N - R) / (N + R)) * N
end

indices_funcs["NIRv"] = NIRv_func

function GEMI_func(
    ::Type{TFL},
    N,
    R;
    const1::Number=TFL(2.0),
    const2::Number=TFL(2.0),
    const3::Number=TFL(2.0),
    const4::Number=TFL(1.5),
    const5::Number=TFL(0.5),
    const6::Number=TFL(0.5),
    const7::Number=TFL(1.0),
    const8::Number=TFL(0.25),
    const9::Number=TFL(2.0),
    const10::Number=TFL(2.0),
    const11::Number=TFL(2),
    const12::Number=TFL(1.5),
    const13::Number=TFL(0.5),
    const14::Number=TFL(0.5),
    const15::Number=TFL(0.125),
    const16::Number=TFL(1),
) where {TFL<:Number}
    return (
        (const1 * ((N^const2) - (R^const3)) + const4 * N + const5 * R) / (N + R + const6)
    ) * (
        const7 -
        const8 * (
            (const9 * ((N^const10) - (R^const11)) + const12 * N + const13 * R) /
            (N + R + const14)
        )
    ) - ((R - const15) / (const16 - R))
end

indices_funcs["GEMI"] = GEMI_func

function FCVI_func(::Type{TFL}, N, R, G, B; const1::Number=TFL(3.0)) where {TFL<:Number}
    return N - ((R + G + B) / const1)
end

indices_funcs["FCVI"] = FCVI_func

function VHVVR_func(::Type{TFL}, VH, VV) where {TFL<:Number}
    return VH / VV
end

indices_funcs["VHVVR"] = VHVVR_func

function GCC_func(::Type{TFL}, G, R, B) where {TFL<:Number}
    return G / (R + G + B)
end

indices_funcs["GCC"] = GCC_func

function WDRVI_func(::Type{TFL}, alpha, N, R) where {TFL<:Number}
    return (alpha * N - R) / (alpha * N + R)
end

indices_funcs["WDRVI"] = WDRVI_func

function ExGR_func(
    ::Type{TFL}, G, R, B; const1::Number=TFL(2.0), const2::Number=TFL(1.3)
) where {TFL<:Number}
    return (const1 * G - R - B) - (const2 * R - G)
end

indices_funcs["ExGR"] = ExGR_func

function DSI_func(::Type{TFL}, S1, N) where {TFL<:Number}
    return S1 / N
end

indices_funcs["DSI"] = DSI_func

function ExG_func(::Type{TFL}, G, R, B; const1::Number=TFL(2)) where {TFL<:Number}
    return const1 * G - R - B
end

indices_funcs["ExG"] = ExG_func

function GSAVI_func(::Type{TFL}, L, N, G; const1::Number=TFL(1.0)) where {TFL<:Number}
    return (const1 + L) * (N - G) / (N + G + L)
end

indices_funcs["GSAVI"] = GSAVI_func

function ATSAVI_func(
    ::Type{TFL},
    sla,
    N,
    R,
    slb;
    const1::Number=TFL(0.08),
    const2::Number=TFL(1),
    const3::Number=TFL(2.0),
) where {TFL<:Number}
    return sla * (N - sla * R - slb) /
           (sla * N + R - sla * slb + const1 * (const2 + sla^const3))
end

indices_funcs["ATSAVI"] = ATSAVI_func

function MLSWI27_func(
    ::Type{TFL}, N, S2; const1::Number=TFL(1.0), const2::Number=TFL(1.0)
) where {TFL<:Number}
    return (const1 - N - S2) / (const2 - N + S2)
end

indices_funcs["MLSWI27"] = MLSWI27_func

function SeLI_func(::Type{TFL}, N2, RE1) where {TFL<:Number}
    return (N2 - RE1) / (N2 + RE1)
end

indices_funcs["SeLI"] = SeLI_func

function NDPI_func(
    ::Type{TFL}, N, alpha, R, S1; const1::Number=TFL(1.0), const2::Number=TFL(1.0)
) where {TFL<:Number}
    return (N - (alpha * R + (const1 - alpha) * S1)) /
           (N + (alpha * R + (const2 - alpha) * S1))
end

indices_funcs["NDPI"] = NDPI_func

function NDGI_func(
    ::Type{TFL},
    lambdaN,
    lambdaR,
    lambdaG,
    G,
    N,
    R;
    const1::Number=TFL(1.0),
    const2::Number=TFL(1.0),
) where {TFL<:Number}
    return (
        ((lambdaN - lambdaR) / (lambdaN - lambdaG)) * G +
        (const1 - ((lambdaN - lambdaR) / (lambdaN - lambdaG))) * N - R
    ) / (
        ((lambdaN - lambdaR) / (lambdaN - lambdaG)) * G +
        (const2 - ((lambdaN - lambdaR) / (lambdaN - lambdaG))) * N +
        R
    )
end

indices_funcs["NDGI"] = NDGI_func

function SR2_func(::Type{TFL}, N, G) where {TFL<:Number}
    return N / G
end

indices_funcs["SR2"] = SR2_func

function NGRDI_func(::Type{TFL}, G, R) where {TFL<:Number}
    return (G - R) / (G + R)
end

indices_funcs["NGRDI"] = NGRDI_func

function NBR2_func(::Type{TFL}, S1, S2) where {TFL<:Number}
    return (S1 - S2) / (S1 + S2)
end

indices_funcs["NBR2"] = NBR2_func

function NDVI705_func(::Type{TFL}, RE2, RE1) where {TFL<:Number}
    return (RE2 - RE1) / (RE2 + RE1)
end

indices_funcs["NDVI705"] = NDVI705_func

function TVI_func(
    ::Type{TFL}, N, R; const1::Number=TFL(0.5), const2::Number=TFL(0.5)
) where {TFL<:Number}
    return (((N - R) / (N + R)) + const1)^const2
end

indices_funcs["TVI"] = TVI_func

function NDBaI_func(::Type{TFL}, S1, T) where {TFL<:Number}
    return (S1 - T) / (S1 + T)
end

indices_funcs["NDBaI"] = NDBaI_func

function SAVIT_func(
    ::Type{TFL},
    L,
    N,
    R,
    T;
    const1::Number=TFL(1.0),
    const2::Number=TFL(10000.0),
    const3::Number=TFL(10000.0),
) where {TFL<:Number}
    return (const1 + L) * (N - (R * T / const2)) / (N + (R * T / const3) + L)
end

indices_funcs["SAVIT"] = SAVIT_func

function WI2_func(::Type{TFL}, B, S2) where {TFL<:Number}
    return (B - S2) / (B + S2)
end

indices_funcs["WI2"] = WI2_func

function NBAI_func(::Type{TFL}, S2, S1, G) where {TFL<:Number}
    return ((S2 - S1) / G) / ((S2 + S1) / G)
end

indices_funcs["NBAI"] = NBAI_func

function BI_func(::Type{TFL}, S1, R, N, B) where {TFL<:Number}
    return ((S1 + R) - (N + B)) / ((S1 + R) + (N + B))
end

indices_funcs["BI"] = BI_func

function RDVI_func(::Type{TFL}, N, R; const1::Number=TFL(0.5)) where {TFL<:Number}
    return (N - R) / ((N + R)^const1)
end

indices_funcs["RDVI"] = RDVI_func

function TGI_func(
    ::Type{TFL},
    R,
    G,
    B;
    const1::Number=TFL(0.5),
    const2::Number=TFL(190),
    const3::Number=TFL(120),
) where {TFL<:Number}
    return -const1 * (const2 * (R - G) - const3 * (R - B))
end

indices_funcs["TGI"] = TGI_func

function NRFIg_func(::Type{TFL}, G, S2) where {TFL<:Number}
    return (G - S2) / (G + S2)
end

indices_funcs["NRFIg"] = NRFIg_func

function MSR_func(
    ::Type{TFL}, N, R; const1::Number=TFL(1), const2::Number=TFL(1), const3::Number=TFL(0.5)
) where {TFL<:Number}
    return (N / R - const1) / ((N / R + const2)^const3)
end

indices_funcs["MSR"] = MSR_func

function TriVI_func(
    ::Type{TFL},
    N,
    G,
    R;
    const1::Number=TFL(0.5),
    const2::Number=TFL(120),
    const3::Number=TFL(200),
) where {TFL<:Number}
    return const1 * (const2 * (N - G) - const3 * (R - G))
end

indices_funcs["TriVI"] = TriVI_func

function ARI_func(
    ::Type{TFL}, G, RE1; const1::Number=TFL(1), const2::Number=TFL(1)
) where {TFL<:Number}
    return (const1 / G) - (const2 / RE1)
end

indices_funcs["ARI"] = ARI_func

function NBRSWIR_func(
    ::Type{TFL}, S2, S1; const1::Number=TFL(0.02), const2::Number=TFL(0.1)
) where {TFL<:Number}
    return (S2 - S1 - const1) / (S2 + S1 + const2)
end

indices_funcs["NBRSWIR"] = NBRSWIR_func

function OCVI_func(::Type{TFL}, N, G, R, cexp) where {TFL<:Number}
    return (N / G) * (R / G)^cexp
end

indices_funcs["OCVI"] = OCVI_func

function NormG_func(::Type{TFL}, G, N, R) where {TFL<:Number}
    return G / (N + G + R)
end

indices_funcs["NormG"] = NormG_func

function BLFEI_func(
    ::Type{TFL}, G, R, S2, S1; const1::Number=TFL(3.0), const2::Number=TFL(3.0)
) where {TFL<:Number}
    return (((G + R + S2) / const1) - S1) / (((G + R + S2) / const2) + S1)
end

indices_funcs["BLFEI"] = BLFEI_func

function DVI_func(::Type{TFL}, N, R) where {TFL<:Number}
    return N - R
end

indices_funcs["DVI"] = DVI_func

function MuWIR_func(
    ::Type{TFL},
    B,
    G,
    N,
    S2,
    S1;
    const1::Number=TFL(4.0),
    const2::Number=TFL(2.0),
    const3::Number=TFL(2.0),
) where {TFL<:Number}
    return -const1 * ((B - G) / (B + G)) +
           const2 * ((G - N) / (G + N)) +
           const3 * ((G - S2) / (G + S2)) - ((G - S1) / (G + S1))
end

indices_funcs["MuWIR"] = MuWIR_func

function MNLI_func(
    ::Type{TFL},
    L,
    N,
    R;
    const1::Number=TFL(1),
    const2::Number=TFL(2),
    const3::Number=TFL(2),
) where {TFL<:Number}
    return (const1 + L) * ((N^const2) - R) / ((N^const3) + R + L)
end

indices_funcs["MNLI"] = MNLI_func

function NDSoiI_func(::Type{TFL}, S2, G) where {TFL<:Number}
    return (S2 - G) / (S2 + G)
end

indices_funcs["NDSoI"] = NDSoiI_func

function NDWIns_func(::Type{TFL}, G, alpha, N) where {TFL<:Number}
    return (G - alpha * N) / (G + N)
end

indices_funcs["NDWIns"] = NDWIns_func

function RI_func(::Type{TFL}, R, G) where {TFL<:Number}
    return (R - G) / (R + G)
end

indices_funcs["RI"] = RI_func

function SARVI_func(::Type{TFL}, L, N, R, B; const1::Number=TFL(1)) where {TFL<:Number}
    return (const1 + L) * (N - (R - (R - B))) / (N + (R - (R - B)) + L)
end

indices_funcs["SARVI"] = SARVI_func

function kIPVI_func(::Type{TFL}, kNN, kNR) where {TFL<:Number}
    return kNN / (kNN + kNR)
end

indices_funcs["kIPVI"] = kIPVI_func

function TWI_func(
    ::Type{TFL},
    RE1,
    RE2,
    G,
    S2,
    B,
    N;
    const1::Number=TFL(2.84),
    const2::Number=TFL(1.25),
    const3::Number=TFL(1.25),
    const4::Number=TFL(0.25),
) where {TFL<:Number}
    return (const1 * (RE1 - RE2) / (G + S2)) +
           ((const2 * (G - B) - (N - B)) / (N + const3 * G - const4 * B))
end

indices_funcs["TWI"] = TWI_func

function MSAVI_func(
    ::Type{TFL},
    N,
    R;
    const1::Number=TFL(0.5),
    const2::Number=TFL(2.0),
    const3::Number=TFL(1),
    const4::Number=TFL(2),
    const5::Number=TFL(1),
    const6::Number=TFL(2),
    const7::Number=TFL(8),
    const8::Number=TFL(0.5),
) where {TFL<:Number}
    return const1 * (
        const2 * N + const3 - (((const4 * N + const5)^const6) - const7 * (N - R))^const8
    )
end

indices_funcs["MSAVI"] = MSAVI_func

function DpRVIVV_func(::Type{TFL}, VH, VV; const1::Number=TFL(4.0)) where {TFL<:Number}
    return (const1 * VH) / (VV + VH)
end

indices_funcs["DpRVIVV"] = DpRVIVV_func

function RVI_func(::Type{TFL}, RE2, R) where {TFL<:Number}
    return RE2 / R
end

indices_funcs["RVI"] = RVI_func

function MRBVI_func(
    ::Type{TFL},
    R,
    B;
    const1::Number=TFL(2.0),
    const2::Number=TFL(2.0),
    const3::Number=TFL(2.0),
    const4::Number=TFL(2.0),
) where {TFL<:Number}
    return (R^const1 - B^const2) / (R^const3 + B^const4)
end

indices_funcs["MRBVI"] = MRBVI_func

function NSTv2_func(::Type{TFL}, N, S2, T) where {TFL<:Number}
    return (N - (S2 + T)) / (N + (S2 + T))
end

indices_funcs["NSTv2"] = NSTv2_func

function TCI_func(
    ::Type{TFL},
    RE1,
    G,
    R;
    const1::Number=TFL(1.2),
    const2::Number=TFL(1.5),
    const3::Number=TFL(0.5),
) where {TFL<:Number}
    return const1 * (RE1 - G) - const2 * (R - G) * (RE1 / R)^const3
end

indices_funcs["TCI"] = TCI_func

function ExR_func(::Type{TFL}, R, G; const1::Number=TFL(1.3)) where {TFL<:Number}
    return const1 * R - G
end

indices_funcs["ExR"] = ExR_func

function CIG_func(::Type{TFL}, N, G; const1::Number=TFL(1.0)) where {TFL<:Number}
    return (N / G) - const1
end

indices_funcs["CIG"] = CIG_func

function NDPolI_func(::Type{TFL}, VV, VH) where {TFL<:Number}
    return (VV - VH) / (VV + VH)
end

indices_funcs["NDPolI"] = NDPolI_func

function BCC_func(::Type{TFL}, B, R, G) where {TFL<:Number}
    return B / (R + G + B)
end

indices_funcs["BCC"] = BCC_func

function SI_func(
    ::Type{TFL},
    B,
    G,
    R;
    const1::Number=TFL(1.0),
    const2::Number=TFL(1.0),
    const3::Number=TFL(1.0),
    const4::Number=TFL(1),
    const5::Number=TFL(3),
) where {TFL<:Number}
    return ((const1 - B) * (const2 - G) * (const3 - R))^(const4 / const5)
end

indices_funcs["SI"] = SI_func

function mSR705_func(::Type{TFL}, RE2, A) where {TFL<:Number}
    return (RE2 - A) / (RE2 + A)
end

indices_funcs["mSR705"] = mSR705_func

function SR555_func(::Type{TFL}, RE2, G) where {TFL<:Number}
    return RE2 / G
end

indices_funcs["SR555"] = SR555_func

function NBRT1_func(
    ::Type{TFL}, N, S2, T; const1::Number=TFL(10000.0), const2::Number=TFL(10000.0)
) where {TFL<:Number}
    return (N - (S2 * T / const1)) / (N + (S2 * T / const2))
end

indices_funcs["NBRT1"] = NBRT1_func

function ANDWI_func(::Type{TFL}, B, G, R, N, S1, S2) where {TFL<:Number}
    return (B + G + R - N - S1 - S2) / (B + G + R + N + S1 + S2)
end

indices_funcs["ANDWI"] = ANDWI_func

function WDVI_func(::Type{TFL}, N, sla, R) where {TFL<:Number}
    return N - sla * R
end

indices_funcs["WDVI"] = WDVI_func

function NWI_func(::Type{TFL}, B, N, S1, S2) where {TFL<:Number}
    return (B - (N + S1 + S2)) / (B + (N + S1 + S2))
end

indices_funcs["NWI"] = NWI_func

function GARI_func(::Type{TFL}, N, G, B, R) where {TFL<:Number}
    return (N - (G - (B - R))) / (N - (G + (B - R)))
end

indices_funcs["GARI"] = GARI_func

function MCARI705_func(
    ::Type{TFL}, RE2, RE1, G; const1::Number=TFL(0.2)
) where {TFL<:Number}
    return ((RE2 - RE1) - const1 * (RE2 - G)) * (RE2 / RE1)
end

indices_funcs["MCARI705"] = MCARI705_func

function NormNIR_func(::Type{TFL}, N, G, R) where {TFL<:Number}
    return N / (N + G + R)
end

indices_funcs["NormNIR"] = NormNIR_func

function SWM_func(::Type{TFL}, B, G, N, S1) where {TFL<:Number}
    return (B + G) / (N + S1)
end

indices_funcs["SWM"] = SWM_func

function mND705_func(::Type{TFL}, RE2, RE1, A) where {TFL<:Number}
    return (RE2 - RE1) / (RE2 + RE1 - A)
end

indices_funcs["mND705"] = mND705_func

function SAVI_func(::Type{TFL}, L, N, R; const1::Number=TFL(1.0)) where {TFL<:Number}
    return (const1 + L) * (N - R) / (N + R + L)
end

indices_funcs["SAVI"] = SAVI_func

function EVI2_func(::Type{TFL}, g, N, R, L; const1::Number=TFL(2.4)) where {TFL<:Number}
    return g * (N - R) / (N + const1 * R + L)
end

indices_funcs["EVI2"] = EVI2_func

function DPDD_func(
    ::Type{TFL}, VV, VH; const1::Number=TFL(2.0), const2::Number=TFL(0.5)
) where {TFL<:Number}
    return (VV + VH) / const1^const2
end

indices_funcs["DPDD"] = DPDD_func

function NIRvP_func(::Type{TFL}, N, R, PAR) where {TFL<:Number}
    return ((N - R) / (N + R)) * N * PAR
end

indices_funcs["NIRvP"] = NIRvP_func

function VHVVD_func(::Type{TFL}, VH, VV) where {TFL<:Number}
    return VH - VV
end

indices_funcs["VHVVD"] = VHVVD_func

function SR3_func(::Type{TFL}, N2, G, RE1) where {TFL<:Number}
    return N2 / (G * RE1)
end

indices_funcs["SR3"] = SR3_func

function NBR_func(::Type{TFL}, N, S2) where {TFL<:Number}
    return (N - S2) / (N + S2)
end

indices_funcs["NBR"] = NBR_func

function EMBI_func(
    ::Type{TFL},
    S1,
    S2,
    N,
    G;
    const1::Number=TFL(0.5),
    const2::Number=TFL(0.5),
    const3::Number=TFL(0.5),
    const4::Number=TFL(1.5),
) where {TFL<:Number}
    return ((((S1 - S2 - N) / (S1 + S2 + N)) + const1) - ((G - S1) / (G + S1)) - const2) /
           ((((S1 - S2 - N) / (S1 + S2 + N)) + const3) + ((G - S1) / (G + S1)) + const4)
end

indices_funcs["EMBI"] = EMBI_func

function GDVI_func(::Type{TFL}, N, nexp, R) where {TFL<:Number}
    return ((N^nexp) - (R^nexp)) / ((N^nexp) + (R^nexp))
end

indices_funcs["GDVI"] = GDVI_func

function MCARIOSAVI_func(
    ::Type{TFL},
    RE1,
    R,
    G,
    N;
    const1::Number=TFL(0.2),
    const2::Number=TFL(1.16),
    const3::Number=TFL(0.16),
) where {TFL<:Number}
    return (((RE1 - R) - const1 * (RE1 - G)) * (RE1 / R)) /
           (const2 * (N - R) / (N + R + const3))
end

indices_funcs["MCARIOSAVI"] = MCARIOSAVI_func

function EBI_func(::Type{TFL}, R, G, B, epsilon) where {TFL<:Number}
    return (R + G + B) / ((G / B) * (R - B + epsilon))
end

indices_funcs["EBI"] = EBI_func

function AWEInsh_func(
    ::Type{TFL},
    G,
    S1,
    N,
    S2;
    const1::Number=TFL(4.0),
    const2::Number=TFL(0.25),
    const3::Number=TFL(2.75),
) where {TFL<:Number}
    return const1 * (G - S1) - const2 * N + const3 * S2
end

indices_funcs["AWEInsh"] = AWEInsh_func

function NDYI_func(::Type{TFL}, G, B) where {TFL<:Number}
    return (G - B) / (G + B)
end

indices_funcs["NDYI"] = NDYI_func

function RCC_func(::Type{TFL}, R, G, B) where {TFL<:Number}
    return R / (R + G + B)
end

indices_funcs["RCC"] = RCC_func

function ARVI_func(::Type{TFL}, N, R, gamma, B) where {TFL<:Number}
    return (N - (R - gamma * (R - B))) / (N + (R - gamma * (R - B)))
end

indices_funcs["ARVI"] = ARVI_func

function IPVI_func(::Type{TFL}, N, R) where {TFL<:Number}
    return N / (N + R)
end

indices_funcs["IPVI"] = IPVI_func

function NDSIWV_func(::Type{TFL}, G, Y) where {TFL<:Number}
    return (G - Y) / (G + Y)
end

indices_funcs["NDSIWV"] = NDSIWV_func

function DSWI4_func(::Type{TFL}, G, R) where {TFL<:Number}
    return G / R
end

indices_funcs["DSWI4"] = DSWI4_func

function VVVHR_func(::Type{TFL}, VV, VH) where {TFL<:Number}
    return VV / VH
end

indices_funcs["VVVHR"] = VVVHR_func

function kNDVI_func(::Type{TFL}, kNN, kNR) where {TFL<:Number}
    return (kNN - kNR) / (kNN + kNR)
end

indices_funcs["kNDVI"] = kNDVI_func

function GOSAVI_func(::Type{TFL}, N, G; const1::Number=TFL(0.16)) where {TFL<:Number}
    return (N - G) / (N + G + const1)
end

indices_funcs["GOSAVI"] = GOSAVI_func

function OSAVI_func(::Type{TFL}, N, R; const1::Number=TFL(0.16)) where {TFL<:Number}
    return (N - R) / (N + R + const1)
end

indices_funcs["OSAVI"] = OSAVI_func

function AFRI2100_func(
    ::Type{TFL}, N, S2; const1::Number=TFL(0.5), const2::Number=TFL(0.5)
) where {TFL<:Number}
    return (N - const1 * S2) / (N + const2 * S2)
end

indices_funcs["AFRI2100"] = AFRI2100_func

function GNDVI_func(::Type{TFL}, N, G) where {TFL<:Number}
    return (N - G) / (N + G)
end

indices_funcs["GNDVI"] = GNDVI_func

function LSWI_func(::Type{TFL}, N, S1) where {TFL<:Number}
    return (N - S1) / (N + S1)
end

indices_funcs["LSWI"] = LSWI_func

function UI_func(::Type{TFL}, S2, N) where {TFL<:Number}
    return (S2 - N) / (S2 + N)
end

indices_funcs["UI"] = UI_func

function S2WI_func(::Type{TFL}, RE1, S2) where {TFL<:Number}
    return (RE1 - S2) / (RE1 + S2)
end

indices_funcs["S2WI"] = S2WI_func

function VIBI_func(::Type{TFL}, N, R, S1) where {TFL<:Number}
    return ((N - R) / (N + R)) / (((N - R) / (N + R)) + ((S1 - N) / (S1 + N)))
end

indices_funcs["VIBI"] = VIBI_func

function NSDSI1_func(::Type{TFL}, S1, S2) where {TFL<:Number}
    return (S1 - S2) / S1
end

indices_funcs["NSDSI1"] = NSDSI1_func

function VVVHS_func(::Type{TFL}, VV, VH) where {TFL<:Number}
    return VV + VH
end

indices_funcs["VVVHS"] = VVVHS_func

function VI6T_func(
    ::Type{TFL}, N, T; const1::Number=TFL(10000.0), const2::Number=TFL(10000.0)
) where {TFL<:Number}
    return (N - T / const1) / (N + T / const2)
end

indices_funcs["VI6T"] = VI6T_func

function kVARI_func(::Type{TFL}, kGG, kGR, kGB) where {TFL<:Number}
    return (kGG - kGR) / (kGG + kGR - kGB)
end

indices_funcs["kVARI"] = kVARI_func

function BWDRVI_func(::Type{TFL}, alpha, N, B) where {TFL<:Number}
    return (alpha * N - B) / (alpha * N + B)
end

indices_funcs["BWDRVI"] = BWDRVI_func

function BAIM_func(
    ::Type{TFL},
    N,
    S2;
    const1::Number=TFL(1.0),
    const2::Number=TFL(0.05),
    const3::Number=TFL(2.0),
    const4::Number=TFL(0.2),
    const5::Number=TFL(2.0),
) where {TFL<:Number}
    return const1 / ((const2 - N)^const3) + ((const4 - S2)^const5)
end

indices_funcs["BAIM"] = BAIM_func

function VDDPI_func(::Type{TFL}, VV, VH) where {TFL<:Number}
    return (VV + VH) / VV
end

indices_funcs["VDDPI"] = VDDPI_func

function BIXS_func(
    ::Type{TFL},
    G,
    R;
    const1::Number=TFL(2.0),
    const2::Number=TFL(2.0),
    const3::Number=TFL(2.0),
    const4::Number=TFL(0.5),
) where {TFL<:Number}
    return (((G^const1) + (R^const2)) / const3)^const4
end

indices_funcs["BIXS"] = BIXS_func

function MCARIOSAVI705_func(
    ::Type{TFL},
    RE2,
    RE1,
    G;
    const1::Number=TFL(0.2),
    const2::Number=TFL(1.16),
    const3::Number=TFL(0.16),
) where {TFL<:Number}
    return (((RE2 - RE1) - const1 * (RE2 - G)) * (RE2 / RE1)) /
           (const2 * (RE2 - RE1) / (RE2 + RE1 + const3))
end

indices_funcs["MCARIOSAVI705"] = MCARIOSAVI705_func

function NDSI_func(::Type{TFL}, G, S1) where {TFL<:Number}
    return (G - S1) / (G + S1)
end

indices_funcs["NDSI"] = NDSI_func

function NDVI_func(::Type{TFL}, N, R) where {TFL<:Number}
    return (N - R) / (N + R)
end

indices_funcs["NDVI"] = NDVI_func

function MCARI_func(::Type{TFL}, RE1, R, G; const1::Number=TFL(0.2)) where {TFL<:Number}
    return ((RE1 - R) - const1 * (RE1 - G)) * (RE1 / R)
end

indices_funcs["MCARI"] = MCARI_func

function MLSWI26_func(
    ::Type{TFL}, N, S1; const1::Number=TFL(1.0), const2::Number=TFL(1.0)
) where {TFL<:Number}
    return (const1 - N - S1) / (const2 - N + S1)
end

indices_funcs["MLSWI26"] = MLSWI26_func

function VgNIRBI_func(::Type{TFL}, G, N) where {TFL<:Number}
    return (G - N) / (G + N)
end

indices_funcs["VgNIRBI"] = VgNIRBI_func

function TCARIOSAVI_func(
    ::Type{TFL},
    RE1,
    R,
    G,
    N;
    const1::Number=TFL(3),
    const2::Number=TFL(0.2),
    const3::Number=TFL(1.16),
    const4::Number=TFL(0.16),
) where {TFL<:Number}
    return (const1 * ((RE1 - R) - const2 * (RE1 - G) * (RE1 / R))) /
           (const3 * (N - R) / (N + R + const4))
end

indices_funcs["TCARIOSAVI"] = TCARIOSAVI_func

function AVI_func(
    ::Type{TFL}, N, R; const1::Number=TFL(1.0), const2::Number=TFL(1), const3::Number=TFL(3)
) where {TFL<:Number}
    return (N * (const1 - R) * (N - R))^(const2 / const3)
end

indices_funcs["AVI"] = AVI_func

function NormR_func(::Type{TFL}, R, N, G) where {TFL<:Number}
    return R / (N + G + R)
end

indices_funcs["NormR"] = NormR_func

function VHVVP_func(::Type{TFL}, VH, VV) where {TFL<:Number}
    return VH * VV
end

indices_funcs["VHVVP"] = VHVVP_func

function NSDS_func(::Type{TFL}, S1, S2) where {TFL<:Number}
    return (S1 - S2) / (S1 + S2)
end

indices_funcs["NSDS"] = NSDS_func

function NDSWIR_func(::Type{TFL}, N, S1) where {TFL<:Number}
    return (N - S1) / (N + S1)
end

indices_funcs["NDSWIR"] = NDSWIR_func

function REDSI_func(
    ::Type{TFL},
    RE3,
    R,
    RE1;
    const1::Number=TFL(705.0),
    const2::Number=TFL(665.0),
    const3::Number=TFL(783.0),
    const4::Number=TFL(665.0),
    const5::Number=TFL(2.0),
) where {TFL<:Number}
    return ((const1 - const2) * (RE3 - R) - (const3 - const4) * (RE1 - R)) / (const5 * R)
end

indices_funcs["REDSI"] = REDSI_func

function DBI_func(::Type{TFL}, B, T1, N, R) where {TFL<:Number}
    return ((B - T1) / (B + T1)) - ((N - R) / (N + R))
end

indices_funcs["DBI"] = DBI_func

function ND705_func(::Type{TFL}, RE2, RE1) where {TFL<:Number}
    return (RE2 - RE1) / (RE2 + RE1)
end

indices_funcs["ND705"] = ND705_func

function MNDWI_func(::Type{TFL}, G, S1) where {TFL<:Number}
    return (G - S1) / (G + S1)
end

indices_funcs["MNDWI"] = MNDWI_func

function RGBVI_func(
    ::Type{TFL}, G, B, R; const1::Number=TFL(2.0), const2::Number=TFL(2.0)
) where {TFL<:Number}
    return (G^const1 - B * R) / (G^const2 + B * R)
end

indices_funcs["RGBVI"] = RGBVI_func

function MSI_func(::Type{TFL}, S1, N) where {TFL<:Number}
    return S1 / N
end

indices_funcs["MSI"] = MSI_func

function RGRI_func(::Type{TFL}, R, G) where {TFL<:Number}
    return R / G
end

indices_funcs["RGRI"] = RGRI_func

function GRVI_func(::Type{TFL}, N, G) where {TFL<:Number}
    return N / G
end

indices_funcs["GRVI"] = GRVI_func

function VARI_func(::Type{TFL}, G, R, B) where {TFL<:Number}
    return (G - R) / (G + R - B)
end

indices_funcs["VARI"] = VARI_func

function NMDI_func(::Type{TFL}, N, S1, S2) where {TFL<:Number}
    return (N - (S1 - S2)) / (N + (S1 - S2))
end

indices_funcs["NMDI"] = NMDI_func

function RENDVI_func(::Type{TFL}, RE2, RE1) where {TFL<:Number}
    return (RE2 - RE1) / (RE2 + RE1)
end

indices_funcs["RENDVI"] = RENDVI_func

function NSDSI2_func(::Type{TFL}, S1, S2) where {TFL<:Number}
    return (S1 - S2) / S2
end

indices_funcs["NSDSI2"] = NSDSI2_func

function TCARI_func(
    ::Type{TFL}, RE1, R, G; const1::Number=TFL(3), const2::Number=TFL(0.2)
) where {TFL<:Number}
    return const1 * ((RE1 - R) - const2 * (RE1 - G) * (RE1 / R))
end

indices_funcs["TCARI"] = TCARI_func

function kEVI_func(::Type{TFL}, g, kNN, kNR, C1, C2, kNB, kNL) where {TFL<:Number}
    return g * (kNN - kNR) / (kNN + C1 * kNR - C2 * kNB + kNL)
end

indices_funcs["kEVI"] = kEVI_func

function ARI2_func(
    ::Type{TFL}, N, G, RE1; const1::Number=TFL(1), const2::Number=TFL(1)
) where {TFL<:Number}
    return N * ((const1 / G) - (const2 / RE1))
end

indices_funcs["ARI2"] = ARI2_func

function GM1_func(::Type{TFL}, RE2, G) where {TFL<:Number}
    return RE2 / G
end

indices_funcs["GM1"] = GM1_func

function SLAVI_func(::Type{TFL}, N, R, S2) where {TFL<:Number}
    return N / (R + S2)
end

indices_funcs["SLAVI"] = SLAVI_func

function GVMI_func(
    ::Type{TFL},
    N,
    S2;
    const1::Number=TFL(0.1),
    const2::Number=TFL(0.02),
    const3::Number=TFL(0.1),
    const4::Number=TFL(0.02),
) where {TFL<:Number}
    return ((N + const1) - (S2 + const2)) / ((N + const3) + (S2 + const4))
end

indices_funcs["GVMI"] = GVMI_func

function NBSIMS_func(
    ::Type{TFL}, G, R, N, B, S2, S1; const1::Number=TFL(0.36)
) where {TFL<:Number}
    return const1 * (G + R + N) - (((B + S2) / G) + S1)
end

indices_funcs["NBSIMS"] = NBSIMS_func

function NBLIOLI_func(::Type{TFL}, R, T1) where {TFL<:Number}
    return (R - T1) / (R + T1)
end

indices_funcs["NBLIOLI"] = NBLIOLI_func

function AWEIsh_func(
    ::Type{TFL},
    B,
    G,
    N,
    S1,
    S2;
    const1::Number=TFL(2.5),
    const2::Number=TFL(1.5),
    const3::Number=TFL(0.25),
) where {TFL<:Number}
    return B + const1 * G - const2 * (N + S1) - const3 * S2
end

indices_funcs["AWEIsh"] = AWEIsh_func

function RFDI_func(::Type{TFL}, HH, HV) where {TFL<:Number}
    return (HH - HV) / (HH + HV)
end

indices_funcs["RFDI"] = RFDI_func

function SIPI_func(::Type{TFL}, N, A, R) where {TFL<:Number}
    return (N - A) / (N - R)
end

indices_funcs["SIPI"] = SIPI_func

function DpRVIHH_func(::Type{TFL}, HV, HH; const1::Number=TFL(4.0)) where {TFL<:Number}
    return (const1 * HV) / (HH + HV)
end

indices_funcs["DpRVIHH"] = DpRVIHH_func

function NDISImndwi_func(
    ::Type{TFL}, T, G, S1, N; const1::Number=TFL(3.0), const2::Number=TFL(3.0)
) where {TFL<:Number}
    return (T - (((G - S1) / (G + S1)) + N + S1) / const1) /
           (T + (((G - S1) / (G + S1)) + N + S1) / const2)
end

indices_funcs["NDISImndwi"] = NDISImndwi_func

function MBWI_func(::Type{TFL}, omega, G, R, N, S1, S2) where {TFL<:Number}
    return (omega * G) - R - N - S1 - S2
end

indices_funcs["MBWI"] = MBWI_func

function GM2_func(::Type{TFL}, RE2, RE1) where {TFL<:Number}
    return RE2 / RE1
end

indices_funcs["GM2"] = GM2_func

function VVVHD_func(::Type{TFL}, VV, VH) where {TFL<:Number}
    return VV - VH
end

indices_funcs["VVVHD"] = VVVHD_func

function VrNIRBI_func(::Type{TFL}, R, N) where {TFL<:Number}
    return (R - N) / (R + N)
end

indices_funcs["VrNIRBI"] = VrNIRBI_func

function SEVI_func(::Type{TFL}, N, R, fdelta; const1::Number=TFL(1.0)) where {TFL<:Number}
    return (N / R) + fdelta * (const1 / R)
end

indices_funcs["SEVI"] = SEVI_func

function NSTv1_func(::Type{TFL}, N, S2, T) where {TFL<:Number}
    return ((N - S2) / (N + S2)) * T
end

indices_funcs["NSTv1"] = NSTv1_func

function NDISIndwi_func(
    ::Type{TFL}, T, G, N, S1; const1::Number=TFL(3.0), const2::Number=TFL(3.0)
) where {TFL<:Number}
    return (T - (((G - N) / (G + N)) + N + S1) / const1) /
           (T + (((G - N) / (G + N)) + N + S1) / const2)
end

indices_funcs["NDISIndwi"] = NDISIndwi_func

function NDGlaI_func(::Type{TFL}, G, R) where {TFL<:Number}
    return (G - R) / (G + R)
end

indices_funcs["NDGlaI"] = NDGlaI_func

function GBNDVI_func(::Type{TFL}, N, G, B) where {TFL<:Number}
    return (N - (G + B)) / (N + (G + B))
end

indices_funcs["GBNDVI"] = GBNDVI_func

function BRBA_func(::Type{TFL}, R, S1) where {TFL<:Number}
    return R / S1
end

indices_funcs["BRBA"] = BRBA_func

function CSI_func(::Type{TFL}, N, S2) where {TFL<:Number}
    return N / S2
end

indices_funcs["CSI"] = CSI_func

function NDVIT_func(
    ::Type{TFL}, N, R, T; const1::Number=TFL(10000.0), const2::Number=TFL(10000.0)
) where {TFL<:Number}
    return (N - (R * T / const1)) / (N + (R * T / const2))
end

indices_funcs["NDVIT"] = NDVIT_func

function MNDVI_func(::Type{TFL}, N, S2) where {TFL<:Number}
    return (N - S2) / (N + S2)
end

indices_funcs["MNDVI"] = MNDVI_func

function BAI_func(
    ::Type{TFL},
    R,
    N;
    const1::Number=TFL(1.0),
    const2::Number=TFL(0.1),
    const3::Number=TFL(2.0),
    const4::Number=TFL(0.06),
    const5::Number=TFL(2.0),
) where {TFL<:Number}
    return const1 / ((const2 - R)^const3 + (const4 - N)^const5)
end

indices_funcs["BAI"] = BAI_func

function TRRVI_func(::Type{TFL}, RE2, R, N; const1::Number=TFL(1.0)) where {TFL<:Number}
    return ((RE2 - R) / (RE2 + R)) / (((N - R) / (N + R)) + const1)
end

indices_funcs["TRRVI"] = TRRVI_func

function EVI_func(::Type{TFL}, g, N, R, C1, C2, B, L) where {TFL<:Number}
    return g * (N - R) / (N + C1 * R - C2 * B + L)
end

indices_funcs["EVI"] = EVI_func

function DBSI_func(::Type{TFL}, S1, G, N, R) where {TFL<:Number}
    return ((S1 - G) / (S1 + G)) - ((N - R) / (N + R))
end

indices_funcs["DBSI"] = DBSI_func

function NDPonI_func(::Type{TFL}, S1, G) where {TFL<:Number}
    return (S1 - G) / (S1 + G)
end

indices_funcs["NDPonI"] = NDPonI_func

function NLI_func(
    ::Type{TFL}, N, R; const1::Number=TFL(2), const2::Number=TFL(2)
) where {TFL<:Number}
    return ((N^const1) - R) / ((N^const2) + R)
end

indices_funcs["NLI"] = NLI_func

function NDSaII_func(::Type{TFL}, R, S1) where {TFL<:Number}
    return (R - S1) / (R + S1)
end

indices_funcs["NDSaII"] = NDSaII_func

function MSR705_func(
    ::Type{TFL},
    RE2,
    RE1;
    const1::Number=TFL(1),
    const2::Number=TFL(1),
    const3::Number=TFL(0.5),
) where {TFL<:Number}
    return (RE2 / RE1 - const1) / ((RE2 / RE1 + const2)^const3)
end

indices_funcs["MSR705"] = MSR705_func

function MTVI1_func(
    ::Type{TFL},
    N,
    G,
    R;
    const1::Number=TFL(1.2),
    const2::Number=TFL(1.2),
    const3::Number=TFL(2.5),
) where {TFL<:Number}
    return const1 * (const2 * (N - G) - const3 * (R - G))
end

indices_funcs["MTVI1"] = MTVI1_func

function IKAW_func(::Type{TFL}, R, B) where {TFL<:Number}
    return (R - B) / (R + B)
end

indices_funcs["IKAW"] = IKAW_func

function MIRBI_func(
    ::Type{TFL},
    S2,
    S1;
    const1::Number=TFL(10.0),
    const2::Number=TFL(9.8),
    const3::Number=TFL(2.0),
) where {TFL<:Number}
    return const1 * S2 - const2 * S1 + const3
end

indices_funcs["MIRBI"] = MIRBI_func

function CSIT_func(::Type{TFL}, N, S2, T; const1::Number=TFL(10000.0)) where {TFL<:Number}
    return N / (S2 * T / const1)
end

indices_funcs["CSIT"] = CSIT_func

function TDVI_func(
    ::Type{TFL},
    N,
    R;
    const1::Number=TFL(1.5),
    const2::Number=TFL(2.0),
    const3::Number=TFL(0.5),
    const4::Number=TFL(0.5),
) where {TFL<:Number}
    return const1 * ((N - R) / ((N^const2 + R + const3)^const4))
end

indices_funcs["TDVI"] = TDVI_func

function DSWI2_func(::Type{TFL}, S1, G) where {TFL<:Number}
    return S1 / G
end

indices_funcs["DSWI2"] = DSWI2_func

function CIRE_func(::Type{TFL}, N, RE1; const1::Number=TFL(1)) where {TFL<:Number}
    return (N / RE1) - const1
end

indices_funcs["CIRE"] = CIRE_func

function NDISIr_func(
    ::Type{TFL}, T, R, N, S1; const1::Number=TFL(3.0), const2::Number=TFL(3.0)
) where {TFL<:Number}
    return (T - (R + N + S1) / const1) / (T + (R + N + S1) / const2)
end

indices_funcs["NDISIr"] = NDISIr_func

function NDDI_func(::Type{TFL}, N, R, G) where {TFL<:Number}
    return (((N - R) / (N + R)) - ((G - N) / (G + N))) /
           (((N - R) / (N + R)) + ((G - N) / (G + N)))
end

indices_funcs["NDDI"] = NDDI_func

function NDREI_func(::Type{TFL}, N, RE1) where {TFL<:Number}
    return (N - RE1) / (N + RE1)
end

indices_funcs["NDREI"] = NDREI_func

function NDTI_func(::Type{TFL}, R, G) where {TFL<:Number}
    return (R - G) / (R + G)
end

indices_funcs["NDTI"] = NDTI_func

function QpRVI_func(
    ::Type{TFL}, HV, HH, VV; const1::Number=TFL(8.0), const2::Number=TFL(2.0)
) where {TFL<:Number}
    return (const1 * HV) / (HH + VV + const2 * HV)
end

indices_funcs["QpRVI"] = QpRVI_func

function DSWI1_func(::Type{TFL}, N, S1) where {TFL<:Number}
    return N / S1
end

indices_funcs["DSWI1"] = DSWI1_func

function EBBI_func(
    ::Type{TFL}, S1, N, T; const1::Number=TFL(10.0), const2::Number=TFL(0.5)
) where {TFL<:Number}
    return (S1 - N) / (const1 * ((S1 + T)^const2))
end

indices_funcs["EBBI"] = EBBI_func

function MCARI1_func(
    ::Type{TFL},
    N,
    R,
    G;
    const1::Number=TFL(1.2),
    const2::Number=TFL(2.5),
    const3::Number=TFL(1.3),
) where {TFL<:Number}
    return const1 * (const2 * (N - R) - const3 * (N - G))
end

indices_funcs["MCARI1"] = MCARI1_func

function BNDVI_func(::Type{TFL}, N, B) where {TFL<:Number}
    return (N - B) / (N + B)
end

indices_funcs["BNDVI"] = BNDVI_func

function NDSII_func(::Type{TFL}, G, N) where {TFL<:Number}
    return (G - N) / (G + N)
end

indices_funcs["NDSII"] = NDSII_func

function NIRvH2_func(::Type{TFL}, N, R, k, lambdaN, lambdaR) where {TFL<:Number}
    return N - R - k * (lambdaN - lambdaR)
end

indices_funcs["NIRvH2"] = NIRvH2_func

function NBRT2_func(
    ::Type{TFL}, N, T, S2; const1::Number=TFL(10000.0), const2::Number=TFL(10000.0)
) where {TFL<:Number}
    return ((N / (T / const1)) - S2) / ((N / (T / const2)) + S2)
end

indices_funcs["NBRT2"] = NBRT2_func

function DVIplus_func(
    ::Type{TFL}, lambdaN, lambdaR, lambdaG, G, N, R; const1::Number=TFL(1.0)
) where {TFL<:Number}
    return ((lambdaN - lambdaR) / (lambdaN - lambdaG)) * G +
           (const1 - ((lambdaN - lambdaR) / (lambdaN - lambdaG))) * N - R
end

indices_funcs["DVIplus"] = DVIplus_func

function CVI_func(::Type{TFL}, N, R, G; const1::Number=TFL(2.0)) where {TFL<:Number}
    return (N * R) / (G^const1)
end

indices_funcs["CVI"] = CVI_func

function RI4XS_func(
    ::Type{TFL}, R, G; const1::Number=TFL(2.0), const2::Number=TFL(4.0)
) where {TFL<:Number}
    return (R^const1) / (G^const2)
end

indices_funcs["RI4XS"] = RI4XS_func

function kRVI_func(::Type{TFL}, kNN, kNR) where {TFL<:Number}
    return kNN / kNR
end

indices_funcs["kRVI"] = kRVI_func

function AFRI1600_func(
    ::Type{TFL}, N, S1; const1::Number=TFL(0.66), const2::Number=TFL(0.66)
) where {TFL<:Number}
    return (N - const1 * S1) / (N + const2 * S1)
end

indices_funcs["AFRI1600"] = AFRI1600_func

function SR705_func(::Type{TFL}, RE2, RE1) where {TFL<:Number}
    return RE2 / RE1
end

indices_funcs["SR705"] = SR705_func

function IBI_func(
    ::Type{TFL},
    S1,
    N,
    R,
    L,
    G;
    const1::Number=TFL(1.0),
    const2::Number=TFL(2.0),
    const3::Number=TFL(1.0),
    const4::Number=TFL(2.0),
) where {TFL<:Number}
    return (
        ((S1 - N) / (S1 + N)) -
        (((N - R) * (const1 + L) / (N + R + L)) + ((G - S1) / (G + S1))) / const2
    ) / (
        ((S1 - N) / (S1 + N)) +
        (((N - R) * (const3 + L) / (N + R + L)) + ((G - S1) / (G + S1))) / const4
    )
end

indices_funcs["IBI"] = IBI_func

function VARI700_func(
    ::Type{TFL},
    RE1,
    R,
    B;
    const1::Number=TFL(1.7),
    const2::Number=TFL(0.7),
    const3::Number=TFL(1.3),
    const4::Number=TFL(1.3),
) where {TFL<:Number}
    return (RE1 - const1 * R + const2 * B) / (RE1 + const3 * R - const4 * B)
end

indices_funcs["VARI700"] = VARI700_func

function NBLI_func(::Type{TFL}, R, T) where {TFL<:Number}
    return (R - T) / (R + T)
end

indices_funcs["NBLI"] = NBLI_func

function NDII_func(::Type{TFL}, N, S1) where {TFL<:Number}
    return (N - S1) / (N + S1)
end

indices_funcs["NDII"] = NDII_func

function S2REP_func(
    ::Type{TFL},
    RE3,
    R,
    RE1,
    RE2;
    const1::Number=TFL(705.0),
    const2::Number=TFL(35.0),
    const3::Number=TFL(2.0),
) where {TFL<:Number}
    return const1 + const2 * ((((RE3 + R) / const3) - RE1) / (RE2 - RE1))
end

indices_funcs["S2REP"] = S2REP_func

function NDMI_func(::Type{TFL}, N, S1) where {TFL<:Number}
    return (N - S1) / (N + S1)
end

indices_funcs["NDMI"] = NDMI_func

function NBUI_func(
    ::Type{TFL},
    S1,
    N,
    T,
    R,
    L,
    G;
    const1::Number=TFL(10.0),
    const2::Number=TFL(0.5),
    const3::Number=TFL(1.0),
) where {TFL<:Number}
    return ((S1 - N) / (const1 * (T + S1)^const2)) -
           (((N - R) * (const3 + L)) / (N - R + L)) - (G - S1) / (G + S1)
end

indices_funcs["NBUI"] = NBUI_func

function GRNDVI_func(::Type{TFL}, N, G, R) where {TFL<:Number}
    return (N - (G + R)) / (N + (G + R))
end

indices_funcs["GRNDVI"] = GRNDVI_func

function NBRT3_func(
    ::Type{TFL}, N, T, S2; const1::Number=TFL(10000.0), const2::Number=TFL(10000.0)
) where {TFL<:Number}
    return ((N - (T / const1)) - S2) / ((N - (T / const2)) + S2)
end

indices_funcs["NBRT3"] = NBRT3_func

function TSAVI_func(::Type{TFL}, sla, N, R, slb) where {TFL<:Number}
    return sla * (N - sla * R - slb) / (sla * N + R - sla * slb)
end

indices_funcs["TSAVI"] = TSAVI_func

function NDWI_func(::Type{TFL}, G, N) where {TFL<:Number}
    return (G - N) / (G + N)
end

indices_funcs["NDWI"] = NDWI_func

function NSDSI3_func(::Type{TFL}, S1, S2) where {TFL<:Number}
    return (S1 - S2) / (S1 + S2)
end

indices_funcs["NSDSI3"] = NSDSI3_func

function PISI_func(
    ::Type{TFL},
    B,
    N;
    const1::Number=TFL(0.8192),
    const2::Number=TFL(0.5735),
    const3::Number=TFL(0.0750),
) where {TFL<:Number}
    return const1 * B - const2 * N + const3
end

indices_funcs["PISI"] = PISI_func

function MTCI_func(::Type{TFL}, RE2, RE1, R) where {TFL<:Number}
    return (RE2 - RE1) / (RE1 - R)
end

indices_funcs["MTCI"] = MTCI_func

function MCARI2_func(
    ::Type{TFL},
    N,
    R,
    G;
    const1::Number=TFL(1.5),
    const2::Number=TFL(2.5),
    const3::Number=TFL(1.3),
    const4::Number=TFL(2.0),
    const5::Number=TFL(1),
    const6::Number=TFL(2),
    const7::Number=TFL(6.0),
    const8::Number=TFL(5),
    const9::Number=TFL(0.5),
    const10::Number=TFL(0.5),
    const11::Number=TFL(0.5),
) where {TFL<:Number}
    return (const1 * (const2 * (N - R) - const3 * (N - G))) / (
        (
            ((const4 * N + const5)^const6) - (const7 * N - const8 * (R^const9)) - const10
        )^const11
    )
end

indices_funcs["MCARI2"] = MCARI2_func

function GLI_func(
    ::Type{TFL}, G, R, B; const1::Number=TFL(2.0), const2::Number=TFL(2.0)
) where {TFL<:Number}
    return (const1 * G - R - B) / (const2 * G + R + B)
end

indices_funcs["GLI"] = GLI_func

function VI700_func(::Type{TFL}, RE1, R) where {TFL<:Number}
    return (RE1 - R) / (RE1 + R)
end

indices_funcs["VI700"] = VI700_func

function NDISIb_func(
    ::Type{TFL}, T, B, N, S1; const1::Number=TFL(3.0), const2::Number=TFL(3.0)
) where {TFL<:Number}
    return (T - (B + N + S1) / const1) / (T + (B + N + S1) / const2)
end

indices_funcs["NDISIb"] = NDISIb_func

function WI2015_func(
    ::Type{TFL},
    G,
    R,
    N,
    S1,
    S2;
    const1::Number=TFL(1.7204),
    const2::Number=TFL(171),
    const3::Number=TFL(3),
    const4::Number=TFL(70),
    const5::Number=TFL(45),
    const6::Number=TFL(71),
) where {TFL<:Number}
    return const1 + const2 * G + const3 * R - const4 * N - const5 * S1 - const6 * S2
end

indices_funcs["WI2015"] = WI2015_func

function BITM_func(
    ::Type{TFL},
    B,
    G,
    R;
    const1::Number=TFL(2.0),
    const2::Number=TFL(2.0),
    const3::Number=TFL(2.0),
    const4::Number=TFL(3.0),
    const5::Number=TFL(0.5),
) where {TFL<:Number}
    return (((B^const1) + (G^const2) + (R^const3)) / const4)^const5
end

indices_funcs["BITM"] = BITM_func

function S3_func(::Type{TFL}, N, R, S1) where {TFL<:Number}
    return (N * (R - S1)) / ((N + R) * (N + S1))
end

indices_funcs["S3"] = S3_func

function TTVI_func(
    ::Type{TFL},
    RE3,
    RE2,
    N2;
    const1::Number=TFL(0.5),
    const2::Number=TFL(865.0),
    const3::Number=TFL(740.0),
    const4::Number=TFL(783.0),
    const5::Number=TFL(740),
) where {TFL<:Number}
    return const1 * ((const2 - const3) * (RE3 - RE2) - (N2 - RE2) * (const4 - const5))
end

indices_funcs["TTVI"] = TTVI_func

function NDCI_func(::Type{TFL}, RE1, R) where {TFL<:Number}
    return (RE1 - R) / (RE1 + R)
end

indices_funcs["NDCI"] = NDCI_func

function NHFD_func(::Type{TFL}, RE1, A) where {TFL<:Number}
    return (RE1 - A) / (RE1 + A)
end

indices_funcs["NHFD"] = NHFD_func

function SAVI2_func(::Type{TFL}, N, R, slb, sla) where {TFL<:Number}
    return N / (R + (slb / sla))
end

indices_funcs["SAVI2"] = SAVI2_func

function DSWI5_func(::Type{TFL}, N, G, S1, R) where {TFL<:Number}
    return (N + G) / (S1 + R)
end

indices_funcs["DSWI5"] = DSWI5_func

function IAVI_func(::Type{TFL}, N, R, gamma, B) where {TFL<:Number}
    return (N - (R - gamma * (B - R))) / (N + (R - gamma * (B - R)))
end

indices_funcs["IAVI"] = IAVI_func
