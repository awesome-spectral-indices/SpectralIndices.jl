indices_funcs = Dict()

function SWI_func(::Type{TFL}, G::Number, N::Number, S1::Number) where {TFL <: Number}
    return (G * (N - S1)) / ((G + N) * (N + S1))
end

function SWI_func(G::Number, N::Number, S1::Number)
    return SWI_func(Float64, G::Number, N::Number, S1::Number)
end

indices_funcs["SWI"] = SWI_func

function WI1_func(::Type{TFL}, G::Number, S2::Number) where {TFL <: Number}
    return (G - S2) / (G + S2)
end

function WI1_func(G::Number, S2::Number)
    return WI1_func(Float64, G::Number, S2::Number)
end

indices_funcs["WI1"] = WI1_func

function NDVIMNDWI_func(::Type{TFL}, N::Number, R::Number, G::Number, S1::Number) where {TFL <: Number}
    return ((N - R)/(N + R)) - ((G - S1)/(G + S1))
end

function NDVIMNDWI_func(N::Number, R::Number, G::Number, S1::Number)
    return NDVIMNDWI_func(Float64, N::Number, R::Number, G::Number, S1::Number)
end

indices_funcs["NDVIMNDWI"] = NDVIMNDWI_func

function BAIS2_func(::Type{TFL}, RE2::Number, RE3::Number, N2::Number, R::Number, S2::Number; const1::Number=TFL(1.0), const2::Number=TFL(0.5), const3::Number=TFL(0.5), const4::Number=TFL(1.0)) where {TFL <: Number}
    return (const1 - ((RE2 * RE3 * N2) / R) ^ const2) * (((S2 - N2)/(S2 + N2) ^ const3) + const4)
end

function BAIS2_func(RE2::Number, RE3::Number, N2::Number, R::Number, S2::Number; const1::Number=TFL(1.0), const2::Number=TFL(0.5), const3::Number=TFL(0.5), const4::Number=TFL(1.0))
    return BAIS2_func(Float64, RE2::Number, RE3::Number, N2::Number, R::Number, S2::Number; const1=const1, const2=const2, const3=const3, const4=const4)
end

indices_funcs["BAIS2"] = BAIS2_func

function PSRI_func(::Type{TFL}, R::Number, B::Number, RE2::Number) where {TFL <: Number}
    return (R - B)/RE2
end

function PSRI_func(R::Number, B::Number, RE2::Number)
    return PSRI_func(Float64, R::Number, B::Number, RE2::Number)
end

indices_funcs["PSRI"] = PSRI_func

function MGRVI_func(::Type{TFL}, G::Number, R::Number; const1::Number=TFL(2.0), const2::Number=TFL(2.0), const3::Number=TFL(2.0), const4::Number=TFL(2.0)) where {TFL <: Number}
    return (G ^ const1 - R ^ const2) / (G ^ const3 + R ^ const4)
end

function MGRVI_func(G::Number, R::Number; const1::Number=TFL(2.0), const2::Number=TFL(2.0), const3::Number=TFL(2.0), const4::Number=TFL(2.0))
    return MGRVI_func(Float64, G::Number, R::Number; const1=const1, const2=const2, const3=const3, const4=const4)
end

indices_funcs["MGRVI"] = MGRVI_func

function SR_func(::Type{TFL}, N::Number, R::Number) where {TFL <: Number}
    return N/R
end

function SR_func(N::Number, R::Number)
    return SR_func(Float64, N::Number, R::Number)
end

indices_funcs["SR"] = SR_func

function MBI_func(::Type{TFL}, S1::Number, S2::Number, N::Number; const1::Number=TFL(0.5)) where {TFL <: Number}
    return ((S1 - S2 - N)/(S1 + S2 + N)) + const1
end

function MBI_func(S1::Number, S2::Number, N::Number; const1::Number=TFL(0.5))
    return MBI_func(Float64, S1::Number, S2::Number, N::Number; const1=const1)
end

indices_funcs["MBI"] = MBI_func

function WRI_func(::Type{TFL}, G::Number, R::Number, N::Number, S1::Number) where {TFL <: Number}
    return (G + R)/(N + S1)
end

function WRI_func(G::Number, R::Number, N::Number, S1::Number)
    return WRI_func(Float64, G::Number, R::Number, N::Number, S1::Number)
end

indices_funcs["WRI"] = WRI_func

function NDISIg_func(::Type{TFL}, T::Number, G::Number, N::Number, S1::Number; const1::Number=TFL(3.0), const2::Number=TFL(3.0)) where {TFL <: Number}
    return (T - (G + N + S1) / const1)/(T + (G + N + S1) / const2)
end

function NDISIg_func(T::Number, G::Number, N::Number, S1::Number; const1::Number=TFL(3.0), const2::Number=TFL(3.0))
    return NDISIg_func(Float64, T::Number, G::Number, N::Number, S1::Number; const1=const1, const2=const2)
end

indices_funcs["NDISIg"] = NDISIg_func

function IRECI_func(::Type{TFL}, RE3::Number, R::Number, RE1::Number, RE2::Number) where {TFL <: Number}
    return (RE3 - R) / (RE1 / RE2)
end

function IRECI_func(RE3::Number, R::Number, RE1::Number, RE2::Number)
    return IRECI_func(Float64, RE3::Number, R::Number, RE1::Number, RE2::Number)
end

indices_funcs["IRECI"] = IRECI_func

function MTVI2_func(::Type{TFL}, N::Number, G::Number, R::Number; const1::Number=TFL(1.5), const2::Number=TFL(1.2), const3::Number=TFL(2.5), const4::Number=TFL(2.0), const5::Number=TFL(1), const6::Number=TFL(2), const7::Number=TFL(6.0), const8::Number=TFL(5), const9::Number=TFL(0.5), const10::Number=TFL(0.5), const11::Number=TFL(0.5)) where {TFL <: Number}
    return (const1 * (const2 * (N - G) - const3 * (R - G))) / ((((const4 * N + const5) ^ const6) - (const7 * N - const8 * (R ^ const9)) - const10) ^ const11)
end

function MTVI2_func(N::Number, G::Number, R::Number; const1::Number=TFL(1.5), const2::Number=TFL(1.2), const3::Number=TFL(2.5), const4::Number=TFL(2.0), const5::Number=TFL(1), const6::Number=TFL(2), const7::Number=TFL(6.0), const8::Number=TFL(5), const9::Number=TFL(0.5), const10::Number=TFL(0.5), const11::Number=TFL(0.5))
    return MTVI2_func(Float64, N::Number, G::Number, R::Number; const1=const1, const2=const2, const3=const3, const4=const4, const5=const5, const6=const6, const7=const7, const8=const8, const9=const9, const10=const10, const11=const11)
end

indices_funcs["MTVI2"] = MTVI2_func

function VIG_func(::Type{TFL}, G::Number, R::Number) where {TFL <: Number}
    return (G - R) / (G + R)
end

function VIG_func(G::Number, R::Number)
    return VIG_func(Float64, G::Number, R::Number)
end

indices_funcs["VIG"] = VIG_func

function TCARIOSAVI705_func(::Type{TFL}, RE2::Number, RE1::Number, G::Number; const1::Number=TFL(3), const2::Number=TFL(0.2), const3::Number=TFL(1.16), const4::Number=TFL(0.16)) where {TFL <: Number}
    return (const1 * ((RE2 - RE1) - const2 * (RE2 - G) * (RE2 / RE1))) / (const3 * (RE2 - RE1) / (RE2 + RE1 + const4))
end

function TCARIOSAVI705_func(RE2::Number, RE1::Number, G::Number; const1::Number=TFL(3), const2::Number=TFL(0.2), const3::Number=TFL(1.16), const4::Number=TFL(0.16))
    return TCARIOSAVI705_func(Float64, RE2::Number, RE1::Number, G::Number; const1=const1, const2=const2, const3=const3, const4=const4)
end

indices_funcs["TCARIOSAVI705"] = TCARIOSAVI705_func

function BaI_func(::Type{TFL}, R::Number, S1::Number, N::Number) where {TFL <: Number}
    return R + S1 - N
end

function BaI_func(R::Number, S1::Number, N::Number)
    return BaI_func(Float64, R::Number, S1::Number, N::Number)
end

indices_funcs["BaI"] = BaI_func

function CCI_func(::Type{TFL}, G1::Number, R::Number) where {TFL <: Number}
    return (G1 - R)/(G1 + R)
end

function CCI_func(G1::Number, R::Number)
    return CCI_func(Float64, G1::Number, R::Number)
end

indices_funcs["CCI"] = CCI_func

function NRFIr_func(::Type{TFL}, R::Number, S2::Number) where {TFL <: Number}
    return (R - S2) / (R + S2)
end

function NRFIr_func(R::Number, S2::Number)
    return NRFIr_func(Float64, R::Number, S2::Number)
end

indices_funcs["NRFIr"] = NRFIr_func

function NBRplus_func(::Type{TFL}, S2::Number, N2::Number, G::Number, B::Number) where {TFL <: Number}
    return (S2 - N2 - G - B)/(S2 + N2 + G + B)
end

function NBRplus_func(S2::Number, N2::Number, G::Number, B::Number)
    return NBRplus_func(Float64, S2::Number, N2::Number, G::Number, B::Number)
end

indices_funcs["NBRplus"] = NBRplus_func

function NDBI_func(::Type{TFL}, S1::Number, N::Number) where {TFL <: Number}
    return (S1 - N) / (S1 + N)
end

function NDBI_func(S1::Number, N::Number)
    return NDBI_func(Float64, S1::Number, N::Number)
end

indices_funcs["NDBI"] = NDBI_func

function NDSInw_func(::Type{TFL}, N::Number, S1::Number, beta::Number) where {TFL <: Number}
    return (N - S1 - beta)/(N + S1)
end

function NDSInw_func(N::Number, S1::Number, beta::Number)
    return NDSInw_func(Float64, N::Number, S1::Number, beta::Number)
end

indices_funcs["NDSInw"] = NDSInw_func

function DSWI3_func(::Type{TFL}, S1::Number, R::Number) where {TFL <: Number}
    return S1/R
end

function DSWI3_func(S1::Number, R::Number)
    return DSWI3_func(Float64, S1::Number, R::Number)
end

indices_funcs["DSWI3"] = DSWI3_func

function NIRv_func(::Type{TFL}, N::Number, R::Number) where {TFL <: Number}
    return ((N - R) / (N + R)) * N
end

function NIRv_func(N::Number, R::Number)
    return NIRv_func(Float64, N::Number, R::Number)
end

indices_funcs["NIRv"] = NIRv_func

function GEMI_func(::Type{TFL}, N::Number, R::Number; const1::Number=TFL(2.0), const2::Number=TFL(2.0), const3::Number=TFL(2.0), const4::Number=TFL(1.5), const5::Number=TFL(0.5), const6::Number=TFL(0.5), const7::Number=TFL(1.0), const8::Number=TFL(0.25), const9::Number=TFL(2.0), const10::Number=TFL(2.0), const11::Number=TFL(2), const12::Number=TFL(1.5), const13::Number=TFL(0.5), const14::Number=TFL(0.5), const15::Number=TFL(0.125), const16::Number=TFL(1)) where {TFL <: Number}
    return ((const1*((N ^ const2)-(R ^ const3)) + const4*N + const5*R)/(N + R + const6))*(const7 - const8*((const9 * ((N ^ const10) - (R ^ const11)) + const12 * N + const13 * R)/(N + R + const14)))-((R - const15)/(const16 - R))
end

function GEMI_func(N::Number, R::Number; const1::Number=TFL(2.0), const2::Number=TFL(2.0), const3::Number=TFL(2.0), const4::Number=TFL(1.5), const5::Number=TFL(0.5), const6::Number=TFL(0.5), const7::Number=TFL(1.0), const8::Number=TFL(0.25), const9::Number=TFL(2.0), const10::Number=TFL(2.0), const11::Number=TFL(2), const12::Number=TFL(1.5), const13::Number=TFL(0.5), const14::Number=TFL(0.5), const15::Number=TFL(0.125), const16::Number=TFL(1))
    return GEMI_func(Float64, N::Number, R::Number; const1=const1, const2=const2, const3=const3, const4=const4, const5=const5, const6=const6, const7=const7, const8=const8, const9=const9, const10=const10, const11=const11, const12=const12, const13=const13, const14=const14, const15=const15, const16=const16)
end

indices_funcs["GEMI"] = GEMI_func

function FCVI_func(::Type{TFL}, N::Number, R::Number, G::Number, B::Number; const1::Number=TFL(3.0)) where {TFL <: Number}
    return N - ((R + G + B)/const1)
end

function FCVI_func(N::Number, R::Number, G::Number, B::Number; const1::Number=TFL(3.0))
    return FCVI_func(Float64, N::Number, R::Number, G::Number, B::Number; const1=const1)
end

indices_funcs["FCVI"] = FCVI_func

function VHVVR_func(::Type{TFL}, VH::Number, VV::Number) where {TFL <: Number}
    return VH/VV
end

function VHVVR_func(VH::Number, VV::Number)
    return VHVVR_func(Float64, VH::Number, VV::Number)
end

indices_funcs["VHVVR"] = VHVVR_func

function GCC_func(::Type{TFL}, G::Number, R::Number, B::Number) where {TFL <: Number}
    return G / (R + G + B)
end

function GCC_func(G::Number, R::Number, B::Number)
    return GCC_func(Float64, G::Number, R::Number, B::Number)
end

indices_funcs["GCC"] = GCC_func

function WDRVI_func(::Type{TFL}, alpha::Number, N::Number, R::Number) where {TFL <: Number}
    return (alpha * N - R) / (alpha * N + R)
end

function WDRVI_func(alpha::Number, N::Number, R::Number)
    return WDRVI_func(Float64, alpha::Number, N::Number, R::Number)
end

indices_funcs["WDRVI"] = WDRVI_func

function ExGR_func(::Type{TFL}, G::Number, R::Number, B::Number; const1::Number=TFL(2.0), const2::Number=TFL(1.3)) where {TFL <: Number}
    return (const1 * G - R - B) - (const2 * R - G)
end

function ExGR_func(G::Number, R::Number, B::Number; const1::Number=TFL(2.0), const2::Number=TFL(1.3))
    return ExGR_func(Float64, G::Number, R::Number, B::Number; const1=const1, const2=const2)
end

indices_funcs["ExGR"] = ExGR_func

function DSI_func(::Type{TFL}, S1::Number, N::Number) where {TFL <: Number}
    return S1/N
end

function DSI_func(S1::Number, N::Number)
    return DSI_func(Float64, S1::Number, N::Number)
end

indices_funcs["DSI"] = DSI_func

function ExG_func(::Type{TFL}, G::Number, R::Number, B::Number; const1::Number=TFL(2)) where {TFL <: Number}
    return const1 * G - R - B
end

function ExG_func(G::Number, R::Number, B::Number; const1::Number=TFL(2))
    return ExG_func(Float64, G::Number, R::Number, B::Number; const1=const1)
end

indices_funcs["ExG"] = ExG_func

function GSAVI_func(::Type{TFL}, L::Number, N::Number, G::Number; const1::Number=TFL(1.0)) where {TFL <: Number}
    return (const1 + L) * (N - G) / (N + G + L)
end

function GSAVI_func(L::Number, N::Number, G::Number; const1::Number=TFL(1.0))
    return GSAVI_func(Float64, L::Number, N::Number, G::Number; const1=const1)
end

indices_funcs["GSAVI"] = GSAVI_func

function ATSAVI_func(::Type{TFL}, sla::Number, N::Number, R::Number, slb::Number; const1::Number=TFL(0.08), const2::Number=TFL(1), const3::Number=TFL(2.0)) where {TFL <: Number}
    return sla * (N - sla * R - slb) / (sla * N + R - sla * slb + const1 * (const2 + sla ^ const3))
end

function ATSAVI_func(sla::Number, N::Number, R::Number, slb::Number; const1::Number=TFL(0.08), const2::Number=TFL(1), const3::Number=TFL(2.0))
    return ATSAVI_func(Float64, sla::Number, N::Number, R::Number, slb::Number; const1=const1, const2=const2, const3=const3)
end

indices_funcs["ATSAVI"] = ATSAVI_func

function MLSWI27_func(::Type{TFL}, N::Number, S2::Number; const1::Number=TFL(1.0), const2::Number=TFL(1.0)) where {TFL <: Number}
    return (const1 - N - S2)/(const2 - N + S2)
end

function MLSWI27_func(N::Number, S2::Number; const1::Number=TFL(1.0), const2::Number=TFL(1.0))
    return MLSWI27_func(Float64, N::Number, S2::Number; const1=const1, const2=const2)
end

indices_funcs["MLSWI27"] = MLSWI27_func

function SeLI_func(::Type{TFL}, N2::Number, RE1::Number) where {TFL <: Number}
    return (N2 - RE1) / (N2 + RE1)
end

function SeLI_func(N2::Number, RE1::Number)
    return SeLI_func(Float64, N2::Number, RE1::Number)
end

indices_funcs["SeLI"] = SeLI_func

function NDPI_func(::Type{TFL}, N::Number, alpha::Number, R::Number, S1::Number; const1::Number=TFL(1.0), const2::Number=TFL(1.0)) where {TFL <: Number}
    return (N - (alpha * R + (const1 - alpha) * S1))/(N + (alpha * R + (const2 - alpha) * S1))
end

function NDPI_func(N::Number, alpha::Number, R::Number, S1::Number; const1::Number=TFL(1.0), const2::Number=TFL(1.0))
    return NDPI_func(Float64, N::Number, alpha::Number, R::Number, S1::Number; const1=const1, const2=const2)
end

indices_funcs["NDPI"] = NDPI_func

function NDGI_func(::Type{TFL}, lambdaN::Number, lambdaR::Number, lambdaG::Number, G::Number, N::Number, R::Number; const1::Number=TFL(1.0), const2::Number=TFL(1.0)) where {TFL <: Number}
    return (((lambdaN - lambdaR)/(lambdaN - lambdaG)) * G + (const1 - ((lambdaN - lambdaR)/(lambdaN - lambdaG))) * N - R)/(((lambdaN - lambdaR)/(lambdaN - lambdaG)) * G + (const2 - ((lambdaN - lambdaR)/(lambdaN - lambdaG))) * N + R)
end

function NDGI_func(lambdaN::Number, lambdaR::Number, lambdaG::Number, G::Number, N::Number, R::Number; const1::Number=TFL(1.0), const2::Number=TFL(1.0))
    return NDGI_func(Float64, lambdaN::Number, lambdaR::Number, lambdaG::Number, G::Number, N::Number, R::Number; const1=const1, const2=const2)
end

indices_funcs["NDGI"] = NDGI_func

function SR2_func(::Type{TFL}, N::Number, G::Number) where {TFL <: Number}
    return N/G
end

function SR2_func(N::Number, G::Number)
    return SR2_func(Float64, N::Number, G::Number)
end

indices_funcs["SR2"] = SR2_func

function NGRDI_func(::Type{TFL}, G::Number, R::Number) where {TFL <: Number}
    return (G - R) / (G + R)
end

function NGRDI_func(G::Number, R::Number)
    return NGRDI_func(Float64, G::Number, R::Number)
end

indices_funcs["NGRDI"] = NGRDI_func

function NBR2_func(::Type{TFL}, S1::Number, S2::Number) where {TFL <: Number}
    return (S1 - S2) / (S1 + S2)
end

function NBR2_func(S1::Number, S2::Number)
    return NBR2_func(Float64, S1::Number, S2::Number)
end

indices_funcs["NBR2"] = NBR2_func

function NDVI705_func(::Type{TFL}, RE2::Number, RE1::Number) where {TFL <: Number}
    return (RE2 - RE1) / (RE2 + RE1)
end

function NDVI705_func(RE2::Number, RE1::Number)
    return NDVI705_func(Float64, RE2::Number, RE1::Number)
end

indices_funcs["NDVI705"] = NDVI705_func

function TVI_func(::Type{TFL}, N::Number, R::Number; const1::Number=TFL(0.5), const2::Number=TFL(0.5)) where {TFL <: Number}
    return (((N - R)/(N + R)) + const1) ^ const2
end

function TVI_func(N::Number, R::Number; const1::Number=TFL(0.5), const2::Number=TFL(0.5))
    return TVI_func(Float64, N::Number, R::Number; const1=const1, const2=const2)
end

indices_funcs["TVI"] = TVI_func

function NDBaI_func(::Type{TFL}, S1::Number, T::Number) where {TFL <: Number}
    return (S1 - T) / (S1 + T)
end

function NDBaI_func(S1::Number, T::Number)
    return NDBaI_func(Float64, S1::Number, T::Number)
end

indices_funcs["NDBaI"] = NDBaI_func

function SAVIT_func(::Type{TFL}, L::Number, N::Number, R::Number, T::Number; const1::Number=TFL(1.0), const2::Number=TFL(10000.0), const3::Number=TFL(10000.0)) where {TFL <: Number}
    return (const1 + L) * (N - (R * T / const2)) / (N + (R * T / const3) + L)
end

function SAVIT_func(L::Number, N::Number, R::Number, T::Number; const1::Number=TFL(1.0), const2::Number=TFL(10000.0), const3::Number=TFL(10000.0))
    return SAVIT_func(Float64, L::Number, N::Number, R::Number, T::Number; const1=const1, const2=const2, const3=const3)
end

indices_funcs["SAVIT"] = SAVIT_func

function WI2_func(::Type{TFL}, B::Number, S2::Number) where {TFL <: Number}
    return (B - S2) / (B + S2)
end

function WI2_func(B::Number, S2::Number)
    return WI2_func(Float64, B::Number, S2::Number)
end

indices_funcs["WI2"] = WI2_func

function NBAI_func(::Type{TFL}, S2::Number, S1::Number, G::Number) where {TFL <: Number}
    return ((S2 - S1)/G)/((S2 + S1)/G)
end

function NBAI_func(S2::Number, S1::Number, G::Number)
    return NBAI_func(Float64, S2::Number, S1::Number, G::Number)
end

indices_funcs["NBAI"] = NBAI_func

function BI_func(::Type{TFL}, S1::Number, R::Number, N::Number, B::Number) where {TFL <: Number}
    return ((S1 + R) - (N + B))/((S1 + R) + (N + B))
end

function BI_func(S1::Number, R::Number, N::Number, B::Number)
    return BI_func(Float64, S1::Number, R::Number, N::Number, B::Number)
end

indices_funcs["BI"] = BI_func

function RDVI_func(::Type{TFL}, N::Number, R::Number; const1::Number=TFL(0.5)) where {TFL <: Number}
    return (N - R) / ((N + R) ^ const1)
end

function RDVI_func(N::Number, R::Number; const1::Number=TFL(0.5))
    return RDVI_func(Float64, N::Number, R::Number; const1=const1)
end

indices_funcs["RDVI"] = RDVI_func

function TGI_func(::Type{TFL}, R::Number, G::Number, B::Number; const1::Number=TFL(0.5), const2::Number=TFL(190), const3::Number=TFL(120)) where {TFL <: Number}
    return - const1 * (const2 * (R - G) - const3 * (R - B))
end

function TGI_func(R::Number, G::Number, B::Number; const1::Number=TFL(0.5), const2::Number=TFL(190), const3::Number=TFL(120))
    return TGI_func(Float64, R::Number, G::Number, B::Number; const1=const1, const2=const2, const3=const3)
end

indices_funcs["TGI"] = TGI_func

function NRFIg_func(::Type{TFL}, G::Number, S2::Number) where {TFL <: Number}
    return (G - S2) / (G + S2)
end

function NRFIg_func(G::Number, S2::Number)
    return NRFIg_func(Float64, G::Number, S2::Number)
end

indices_funcs["NRFIg"] = NRFIg_func

function MSR_func(::Type{TFL}, N::Number, R::Number; const1::Number=TFL(1), const2::Number=TFL(1), const3::Number=TFL(0.5)) where {TFL <: Number}
    return (N / R - const1) / ((N / R + const2) ^ const3)
end

function MSR_func(N::Number, R::Number; const1::Number=TFL(1), const2::Number=TFL(1), const3::Number=TFL(0.5))
    return MSR_func(Float64, N::Number, R::Number; const1=const1, const2=const2, const3=const3)
end

indices_funcs["MSR"] = MSR_func

function TriVI_func(::Type{TFL}, N::Number, G::Number, R::Number; const1::Number=TFL(0.5), const2::Number=TFL(120), const3::Number=TFL(200)) where {TFL <: Number}
    return const1 * (const2 * (N - G) - const3 * (R - G))
end

function TriVI_func(N::Number, G::Number, R::Number; const1::Number=TFL(0.5), const2::Number=TFL(120), const3::Number=TFL(200))
    return TriVI_func(Float64, N::Number, G::Number, R::Number; const1=const1, const2=const2, const3=const3)
end

indices_funcs["TriVI"] = TriVI_func

function ARI_func(::Type{TFL}, G::Number, RE1::Number; const1::Number=TFL(1), const2::Number=TFL(1)) where {TFL <: Number}
    return (const1 / G) - (const2 / RE1)
end

function ARI_func(G::Number, RE1::Number; const1::Number=TFL(1), const2::Number=TFL(1))
    return ARI_func(Float64, G::Number, RE1::Number; const1=const1, const2=const2)
end

indices_funcs["ARI"] = ARI_func

function NBRSWIR_func(::Type{TFL}, S2::Number, S1::Number; const1::Number=TFL(0.02), const2::Number=TFL(0.1)) where {TFL <: Number}
    return (S2 - S1 - const1)/(S2 + S1 + const2)
end

function NBRSWIR_func(S2::Number, S1::Number; const1::Number=TFL(0.02), const2::Number=TFL(0.1))
    return NBRSWIR_func(Float64, S2::Number, S1::Number; const1=const1, const2=const2)
end

indices_funcs["NBRSWIR"] = NBRSWIR_func

function OCVI_func(::Type{TFL}, N::Number, G::Number, R::Number, cexp::Number) where {TFL <: Number}
    return (N / G) * (R / G) ^ cexp
end

function OCVI_func(N::Number, G::Number, R::Number, cexp::Number)
    return OCVI_func(Float64, N::Number, G::Number, R::Number, cexp::Number)
end

indices_funcs["OCVI"] = OCVI_func

function NormG_func(::Type{TFL}, G::Number, N::Number, R::Number) where {TFL <: Number}
    return G/(N + G + R)
end

function NormG_func(G::Number, N::Number, R::Number)
    return NormG_func(Float64, G::Number, N::Number, R::Number)
end

indices_funcs["NormG"] = NormG_func

function BLFEI_func(::Type{TFL}, G::Number, R::Number, S2::Number, S1::Number; const1::Number=TFL(3.0), const2::Number=TFL(3.0)) where {TFL <: Number}
    return (((G+R+S2)/const1)-S1)/(((G+R+S2)/const2)+S1)
end

function BLFEI_func(G::Number, R::Number, S2::Number, S1::Number; const1::Number=TFL(3.0), const2::Number=TFL(3.0))
    return BLFEI_func(Float64, G::Number, R::Number, S2::Number, S1::Number; const1=const1, const2=const2)
end

indices_funcs["BLFEI"] = BLFEI_func

function DVI_func(::Type{TFL}, N::Number, R::Number) where {TFL <: Number}
    return N - R
end

function DVI_func(N::Number, R::Number)
    return DVI_func(Float64, N::Number, R::Number)
end

indices_funcs["DVI"] = DVI_func

function MuWIR_func(::Type{TFL}, B::Number, G::Number, N::Number, S2::Number, S1::Number; const1::Number=TFL(4.0), const2::Number=TFL(2.0), const3::Number=TFL(2.0)) where {TFL <: Number}
    return -const1 * ((B - G)/(B + G)) + const2 * ((G - N)/(G + N)) + const3 * ((G - S2)/(G + S2)) - ((G - S1)/(G + S1))
end

function MuWIR_func(B::Number, G::Number, N::Number, S2::Number, S1::Number; const1::Number=TFL(4.0), const2::Number=TFL(2.0), const3::Number=TFL(2.0))
    return MuWIR_func(Float64, B::Number, G::Number, N::Number, S2::Number, S1::Number; const1=const1, const2=const2, const3=const3)
end

indices_funcs["MuWIR"] = MuWIR_func

function MNLI_func(::Type{TFL}, L::Number, N::Number, R::Number; const1::Number=TFL(1), const2::Number=TFL(2), const3::Number=TFL(2)) where {TFL <: Number}
    return (const1 + L)*((N ^ const2) - R)/((N ^ const3) + R + L)
end

function MNLI_func(L::Number, N::Number, R::Number; const1::Number=TFL(1), const2::Number=TFL(2), const3::Number=TFL(2))
    return MNLI_func(Float64, L::Number, N::Number, R::Number; const1=const1, const2=const2, const3=const3)
end

indices_funcs["MNLI"] = MNLI_func

function NDSoiI_func(::Type{TFL}, S2::Number, G::Number) where {TFL <: Number}
    return (S2 - G)/(S2 + G)
end

function NDSoiI_func(S2::Number, G::Number)
    return NDSoiI_func(Float64, S2::Number, G::Number)
end

indices_funcs["NDSoI"] = NDSoiI_func

function NDWIns_func(::Type{TFL}, G::Number, alpha::Number, N::Number) where {TFL <: Number}
    return (G - alpha * N)/(G + N)
end

function NDWIns_func(G::Number, alpha::Number, N::Number)
    return NDWIns_func(Float64, G::Number, alpha::Number, N::Number)
end

indices_funcs["NDWIns"] = NDWIns_func

function RI_func(::Type{TFL}, R::Number, G::Number) where {TFL <: Number}
    return (R - G)/(R + G)
end

function RI_func(R::Number, G::Number)
    return RI_func(Float64, R::Number, G::Number)
end

indices_funcs["RI"] = RI_func

function SARVI_func(::Type{TFL}, L::Number, N::Number, R::Number, B::Number; const1::Number=TFL(1)) where {TFL <: Number}
    return (const1 + L)*(N - (R - (R - B))) / (N + (R - (R - B)) + L)
end

function SARVI_func(L::Number, N::Number, R::Number, B::Number; const1::Number=TFL(1))
    return SARVI_func(Float64, L::Number, N::Number, R::Number, B::Number; const1=const1)
end

indices_funcs["SARVI"] = SARVI_func

function kIPVI_func(::Type{TFL}, kNN::Number, kNR::Number) where {TFL <: Number}
    return kNN/(kNN + kNR)
end

function kIPVI_func(kNN::Number, kNR::Number)
    return kIPVI_func(Float64, kNN::Number, kNR::Number)
end

indices_funcs["kIPVI"] = kIPVI_func

function TWI_func(::Type{TFL}, RE1::Number, RE2::Number, G::Number, S2::Number, B::Number, N::Number; const1::Number=TFL(2.84), const2::Number=TFL(1.25), const3::Number=TFL(1.25), const4::Number=TFL(0.25)) where {TFL <: Number}
    return (const1 * (RE1 - RE2) / (G + S2)) + ((const2 * (G - B) - (N - B)) / (N + const3 * G - const4 * B))
end

function TWI_func(RE1::Number, RE2::Number, G::Number, S2::Number, B::Number, N::Number; const1::Number=TFL(2.84), const2::Number=TFL(1.25), const3::Number=TFL(1.25), const4::Number=TFL(0.25))
    return TWI_func(Float64, RE1::Number, RE2::Number, G::Number, S2::Number, B::Number, N::Number; const1=const1, const2=const2, const3=const3, const4=const4)
end

indices_funcs["TWI"] = TWI_func

function MSAVI_func(::Type{TFL}, N::Number, R::Number; const1::Number=TFL(0.5), const2::Number=TFL(2.0), const3::Number=TFL(1), const4::Number=TFL(2), const5::Number=TFL(1), const6::Number=TFL(2), const7::Number=TFL(8), const8::Number=TFL(0.5)) where {TFL <: Number}
    return const1 * (const2 * N + const3 - (((const4 * N + const5) ^ const6) - const7 * (N - R)) ^ const8)
end

function MSAVI_func(N::Number, R::Number; const1::Number=TFL(0.5), const2::Number=TFL(2.0), const3::Number=TFL(1), const4::Number=TFL(2), const5::Number=TFL(1), const6::Number=TFL(2), const7::Number=TFL(8), const8::Number=TFL(0.5))
    return MSAVI_func(Float64, N::Number, R::Number; const1=const1, const2=const2, const3=const3, const4=const4, const5=const5, const6=const6, const7=const7, const8=const8)
end

indices_funcs["MSAVI"] = MSAVI_func

function DpRVIVV_func(::Type{TFL}, VH::Number, VV::Number; const1::Number=TFL(4.0)) where {TFL <: Number}
    return (const1 * VH)/(VV + VH)
end

function DpRVIVV_func(VH::Number, VV::Number; const1::Number=TFL(4.0))
    return DpRVIVV_func(Float64, VH::Number, VV::Number; const1=const1)
end

indices_funcs["DpRVIVV"] = DpRVIVV_func

function RVI_func(::Type{TFL}, RE2::Number, R::Number) where {TFL <: Number}
    return RE2 / R
end

function RVI_func(RE2::Number, R::Number)
    return RVI_func(Float64, RE2::Number, R::Number)
end

indices_funcs["RVI"] = RVI_func

function MRBVI_func(::Type{TFL}, R::Number, B::Number; const1::Number=TFL(2.0), const2::Number=TFL(2.0), const3::Number=TFL(2.0), const4::Number=TFL(2.0)) where {TFL <: Number}
    return (R ^ const1 - B ^ const2)/(R ^ const3 + B ^ const4)
end

function MRBVI_func(R::Number, B::Number; const1::Number=TFL(2.0), const2::Number=TFL(2.0), const3::Number=TFL(2.0), const4::Number=TFL(2.0))
    return MRBVI_func(Float64, R::Number, B::Number; const1=const1, const2=const2, const3=const3, const4=const4)
end

indices_funcs["MRBVI"] = MRBVI_func

function NSTv2_func(::Type{TFL}, N::Number, S2::Number, T::Number) where {TFL <: Number}
    return (N-(S2+T))/(N+(S2+T))
end

function NSTv2_func(N::Number, S2::Number, T::Number)
    return NSTv2_func(Float64, N::Number, S2::Number, T::Number)
end

indices_funcs["NSTv2"] = NSTv2_func

function TCI_func(::Type{TFL}, RE1::Number, G::Number, R::Number; const1::Number=TFL(1.2), const2::Number=TFL(1.5), const3::Number=TFL(0.5)) where {TFL <: Number}
    return const1 * (RE1 - G) - const2 * (R - G) * (RE1 / R) ^ const3
end

function TCI_func(RE1::Number, G::Number, R::Number; const1::Number=TFL(1.2), const2::Number=TFL(1.5), const3::Number=TFL(0.5))
    return TCI_func(Float64, RE1::Number, G::Number, R::Number; const1=const1, const2=const2, const3=const3)
end

indices_funcs["TCI"] = TCI_func

function ExR_func(::Type{TFL}, R::Number, G::Number; const1::Number=TFL(1.3)) where {TFL <: Number}
    return const1 * R - G
end

function ExR_func(R::Number, G::Number; const1::Number=TFL(1.3))
    return ExR_func(Float64, R::Number, G::Number; const1=const1)
end

indices_funcs["ExR"] = ExR_func

function CIG_func(::Type{TFL}, N::Number, G::Number; const1::Number=TFL(1.0)) where {TFL <: Number}
    return (N / G) - const1
end

function CIG_func(N::Number, G::Number; const1::Number=TFL(1.0))
    return CIG_func(Float64, N::Number, G::Number; const1=const1)
end

indices_funcs["CIG"] = CIG_func

function NDPolI_func(::Type{TFL}, VV::Number, VH::Number) where {TFL <: Number}
    return (VV - VH)/(VV + VH)
end

function NDPolI_func(VV::Number, VH::Number)
    return NDPolI_func(Float64, VV::Number, VH::Number)
end

indices_funcs["NDPolI"] = NDPolI_func

function BCC_func(::Type{TFL}, B::Number, R::Number, G::Number) where {TFL <: Number}
    return B / (R + G + B)
end

function BCC_func(B::Number, R::Number, G::Number)
    return BCC_func(Float64, B::Number, R::Number, G::Number)
end

indices_funcs["BCC"] = BCC_func

function SI_func(::Type{TFL}, B::Number, G::Number, R::Number; const1::Number=TFL(1.0), const2::Number=TFL(1.0), const3::Number=TFL(1.0), const4::Number=TFL(1), const5::Number=TFL(3)) where {TFL <: Number}
    return ((const1 - B) * (const2 - G) * (const3 - R)) ^ (const4/const5)
end

function SI_func(B::Number, G::Number, R::Number; const1::Number=TFL(1.0), const2::Number=TFL(1.0), const3::Number=TFL(1.0), const4::Number=TFL(1), const5::Number=TFL(3))
    return SI_func(Float64, B::Number, G::Number, R::Number; const1=const1, const2=const2, const3=const3, const4=const4, const5=const5)
end

indices_funcs["SI"] = SI_func

function mSR705_func(::Type{TFL}, RE2::Number, A::Number) where {TFL <: Number}
    return (RE2 - A)/(RE2 + A)
end

function mSR705_func(RE2::Number, A::Number)
    return mSR705_func(Float64, RE2::Number, A::Number)
end

indices_funcs["mSR705"] = mSR705_func

function SR555_func(::Type{TFL}, RE2::Number, G::Number) where {TFL <: Number}
    return RE2 / G
end

function SR555_func(RE2::Number, G::Number)
    return SR555_func(Float64, RE2::Number, G::Number)
end

indices_funcs["SR555"] = SR555_func

function NBRT1_func(::Type{TFL}, N::Number, S2::Number, T::Number; const1::Number=TFL(10000.0), const2::Number=TFL(10000.0)) where {TFL <: Number}
    return (N - (S2 * T / const1)) / (N + (S2 * T / const2))
end

function NBRT1_func(N::Number, S2::Number, T::Number; const1::Number=TFL(10000.0), const2::Number=TFL(10000.0))
    return NBRT1_func(Float64, N::Number, S2::Number, T::Number; const1=const1, const2=const2)
end

indices_funcs["NBRT1"] = NBRT1_func

function ANDWI_func(::Type{TFL}, B::Number, G::Number, R::Number, N::Number, S1::Number, S2::Number) where {TFL <: Number}
    return (B + G + R - N - S1 - S2)/(B + G + R + N + S1 + S2)
end

function ANDWI_func(B::Number, G::Number, R::Number, N::Number, S1::Number, S2::Number)
    return ANDWI_func(Float64, B::Number, G::Number, R::Number, N::Number, S1::Number, S2::Number)
end

indices_funcs["ANDWI"] = ANDWI_func

function WDVI_func(::Type{TFL}, N::Number, sla::Number, R::Number) where {TFL <: Number}
    return N - sla * R
end

function WDVI_func(N::Number, sla::Number, R::Number)
    return WDVI_func(Float64, N::Number, sla::Number, R::Number)
end

indices_funcs["WDVI"] = WDVI_func

function NWI_func(::Type{TFL}, B::Number, N::Number, S1::Number, S2::Number) where {TFL <: Number}
    return (B - (N + S1 + S2))/(B + (N + S1 + S2))
end

function NWI_func(B::Number, N::Number, S1::Number, S2::Number)
    return NWI_func(Float64, B::Number, N::Number, S1::Number, S2::Number)
end

indices_funcs["NWI"] = NWI_func

function GARI_func(::Type{TFL}, N::Number, G::Number, B::Number, R::Number) where {TFL <: Number}
    return (N - (G - (B - R))) / (N - (G + (B - R)))
end

function GARI_func(N::Number, G::Number, B::Number, R::Number)
    return GARI_func(Float64, N::Number, G::Number, B::Number, R::Number)
end

indices_funcs["GARI"] = GARI_func

function MCARI705_func(::Type{TFL}, RE2::Number, RE1::Number, G::Number; const1::Number=TFL(0.2)) where {TFL <: Number}
    return ((RE2 - RE1) - const1 * (RE2 - G)) * (RE2 / RE1)
end

function MCARI705_func(RE2::Number, RE1::Number, G::Number; const1::Number=TFL(0.2))
    return MCARI705_func(Float64, RE2::Number, RE1::Number, G::Number; const1=const1)
end

indices_funcs["MCARI705"] = MCARI705_func

function NormNIR_func(::Type{TFL}, N::Number, G::Number, R::Number) where {TFL <: Number}
    return N/(N + G + R)
end

function NormNIR_func(N::Number, G::Number, R::Number)
    return NormNIR_func(Float64, N::Number, G::Number, R::Number)
end

indices_funcs["NormNIR"] = NormNIR_func

function SWM_func(::Type{TFL}, B::Number, G::Number, N::Number, S1::Number) where {TFL <: Number}
    return (B + G)/(N + S1)
end

function SWM_func(B::Number, G::Number, N::Number, S1::Number)
    return SWM_func(Float64, B::Number, G::Number, N::Number, S1::Number)
end

indices_funcs["SWM"] = SWM_func

function mND705_func(::Type{TFL}, RE2::Number, RE1::Number, A::Number) where {TFL <: Number}
    return (RE2 - RE1)/(RE2 + RE1 - A)
end

function mND705_func(RE2::Number, RE1::Number, A::Number)
    return mND705_func(Float64, RE2::Number, RE1::Number, A::Number)
end

indices_funcs["mND705"] = mND705_func

function SAVI_func(::Type{TFL}, L::Number, N::Number, R::Number; const1::Number=TFL(1.0)) where {TFL <: Number}
    return (const1 + L) * (N - R) / (N + R + L)
end

function SAVI_func(L::Number, N::Number, R::Number; const1::Number=TFL(1.0))
    return SAVI_func(Float64, L::Number, N::Number, R::Number; const1=const1)
end

indices_funcs["SAVI"] = SAVI_func

function EVI2_func(::Type{TFL}, g::Number, N::Number, R::Number, L::Number; const1::Number=TFL(2.4)) where {TFL <: Number}
    return g * (N - R) / (N + const1 * R + L)
end

function EVI2_func(g::Number, N::Number, R::Number, L::Number; const1::Number=TFL(2.4))
    return EVI2_func(Float64, g::Number, N::Number, R::Number, L::Number; const1=const1)
end

indices_funcs["EVI2"] = EVI2_func

function DPDD_func(::Type{TFL}, VV::Number, VH::Number; const1::Number=TFL(2.0), const2::Number=TFL(0.5)) where {TFL <: Number}
    return (VV + VH)/const1 ^ const2
end

function DPDD_func(VV::Number, VH::Number; const1::Number=TFL(2.0), const2::Number=TFL(0.5))
    return DPDD_func(Float64, VV::Number, VH::Number; const1=const1, const2=const2)
end

indices_funcs["DPDD"] = DPDD_func

function NIRvP_func(::Type{TFL}, N::Number, R::Number, PAR::Number) where {TFL <: Number}
    return ((N - R) / (N + R)) * N * PAR
end

function NIRvP_func(N::Number, R::Number, PAR::Number)
    return NIRvP_func(Float64, N::Number, R::Number, PAR::Number)
end

indices_funcs["NIRvP"] = NIRvP_func

function VHVVD_func(::Type{TFL}, VH::Number, VV::Number) where {TFL <: Number}
    return VH - VV
end

function VHVVD_func(VH::Number, VV::Number)
    return VHVVD_func(Float64, VH::Number, VV::Number)
end

indices_funcs["VHVVD"] = VHVVD_func

function SR3_func(::Type{TFL}, N2::Number, G::Number, RE1::Number) where {TFL <: Number}
    return N2/(G * RE1)
end

function SR3_func(N2::Number, G::Number, RE1::Number)
    return SR3_func(Float64, N2::Number, G::Number, RE1::Number)
end

indices_funcs["SR3"] = SR3_func

function NBR_func(::Type{TFL}, N::Number, S2::Number) where {TFL <: Number}
    return (N - S2) / (N + S2)
end

function NBR_func(N::Number, S2::Number)
    return NBR_func(Float64, N::Number, S2::Number)
end

indices_funcs["NBR"] = NBR_func

function EMBI_func(::Type{TFL}, S1::Number, S2::Number, N::Number, G::Number; const1::Number=TFL(0.5), const2::Number=TFL(0.5), const3::Number=TFL(0.5), const4::Number=TFL(1.5)) where {TFL <: Number}
    return ((((S1 - S2 - N)/(S1 + S2 + N)) + const1) - ((G - S1)/(G + S1)) - const2)/((((S1 - S2 - N)/(S1 + S2 + N)) + const3) + ((G - S1)/(G + S1)) + const4)
end

function EMBI_func(S1::Number, S2::Number, N::Number, G::Number; const1::Number=TFL(0.5), const2::Number=TFL(0.5), const3::Number=TFL(0.5), const4::Number=TFL(1.5))
    return EMBI_func(Float64, S1::Number, S2::Number, N::Number, G::Number; const1=const1, const2=const2, const3=const3, const4=const4)
end

indices_funcs["EMBI"] = EMBI_func

function GDVI_func(::Type{TFL}, N::Number, nexp::Number, R::Number) where {TFL <: Number}
    return ((N ^ nexp) - (R ^ nexp)) / ((N ^ nexp) + (R ^ nexp))
end

function GDVI_func(N::Number, nexp::Number, R::Number)
    return GDVI_func(Float64, N::Number, nexp::Number, R::Number)
end

indices_funcs["GDVI"] = GDVI_func

function MCARIOSAVI_func(::Type{TFL}, RE1::Number, R::Number, G::Number, N::Number; const1::Number=TFL(0.2), const2::Number=TFL(1.16), const3::Number=TFL(0.16)) where {TFL <: Number}
    return (((RE1 - R) - const1 * (RE1 - G)) * (RE1 / R)) / (const2 * (N - R) / (N + R + const3))
end

function MCARIOSAVI_func(RE1::Number, R::Number, G::Number, N::Number; const1::Number=TFL(0.2), const2::Number=TFL(1.16), const3::Number=TFL(0.16))
    return MCARIOSAVI_func(Float64, RE1::Number, R::Number, G::Number, N::Number; const1=const1, const2=const2, const3=const3)
end

indices_funcs["MCARIOSAVI"] = MCARIOSAVI_func

function EBI_func(::Type{TFL}, R::Number, G::Number, B::Number, epsilon::Number) where {TFL <: Number}
    return (R + G + B)/((G/B) * (R - B + epsilon))
end

function EBI_func(R::Number, G::Number, B::Number, epsilon::Number)
    return EBI_func(Float64, R::Number, G::Number, B::Number, epsilon::Number)
end

indices_funcs["EBI"] = EBI_func

function AWEInsh_func(::Type{TFL}, G::Number, S1::Number, N::Number, S2::Number; const1::Number=TFL(4.0), const2::Number=TFL(0.25), const3::Number=TFL(2.75)) where {TFL <: Number}
    return const1 * (G - S1) - const2 * N + const3 * S2
end

function AWEInsh_func(G::Number, S1::Number, N::Number, S2::Number; const1::Number=TFL(4.0), const2::Number=TFL(0.25), const3::Number=TFL(2.75))
    return AWEInsh_func(Float64, G::Number, S1::Number, N::Number, S2::Number; const1=const1, const2=const2, const3=const3)
end

indices_funcs["AWEInsh"] = AWEInsh_func

function NDYI_func(::Type{TFL}, G::Number, B::Number) where {TFL <: Number}
    return (G - B) / (G + B)
end

function NDYI_func(G::Number, B::Number)
    return NDYI_func(Float64, G::Number, B::Number)
end

indices_funcs["NDYI"] = NDYI_func

function RCC_func(::Type{TFL}, R::Number, G::Number, B::Number) where {TFL <: Number}
    return R / (R + G + B)
end

function RCC_func(R::Number, G::Number, B::Number)
    return RCC_func(Float64, R::Number, G::Number, B::Number)
end

indices_funcs["RCC"] = RCC_func

function ARVI_func(::Type{TFL}, N::Number, R::Number, gamma::Number, B::Number) where {TFL <: Number}
    return (N - (R - gamma * (R - B))) / (N + (R - gamma * (R - B)))
end

function ARVI_func(N::Number, R::Number, gamma::Number, B::Number)
    return ARVI_func(Float64, N::Number, R::Number, gamma::Number, B::Number)
end

indices_funcs["ARVI"] = ARVI_func

function IPVI_func(::Type{TFL}, N::Number, R::Number) where {TFL <: Number}
    return N/(N + R)
end

function IPVI_func(N::Number, R::Number)
    return IPVI_func(Float64, N::Number, R::Number)
end

indices_funcs["IPVI"] = IPVI_func

function NDSIWV_func(::Type{TFL}, G::Number, Y::Number) where {TFL <: Number}
    return (G - Y)/(G + Y)
end

function NDSIWV_func(G::Number, Y::Number)
    return NDSIWV_func(Float64, G::Number, Y::Number)
end

indices_funcs["NDSIWV"] = NDSIWV_func

function DSWI4_func(::Type{TFL}, G::Number, R::Number) where {TFL <: Number}
    return G/R
end

function DSWI4_func(G::Number, R::Number)
    return DSWI4_func(Float64, G::Number, R::Number)
end

indices_funcs["DSWI4"] = DSWI4_func

function VVVHR_func(::Type{TFL}, VV::Number, VH::Number) where {TFL <: Number}
    return VV/VH
end

function VVVHR_func(VV::Number, VH::Number)
    return VVVHR_func(Float64, VV::Number, VH::Number)
end

indices_funcs["VVVHR"] = VVVHR_func

function kNDVI_func(::Type{TFL}, kNN::Number, kNR::Number) where {TFL <: Number}
    return (kNN - kNR)/(kNN + kNR)
end

function kNDVI_func(kNN::Number, kNR::Number)
    return kNDVI_func(Float64, kNN::Number, kNR::Number)
end

indices_funcs["kNDVI"] = kNDVI_func

function GOSAVI_func(::Type{TFL}, N::Number, G::Number; const1::Number=TFL(0.16)) where {TFL <: Number}
    return (N - G) / (N + G + const1)
end

function GOSAVI_func(N::Number, G::Number; const1::Number=TFL(0.16))
    return GOSAVI_func(Float64, N::Number, G::Number; const1=const1)
end

indices_funcs["GOSAVI"] = GOSAVI_func

function OSAVI_func(::Type{TFL}, N::Number, R::Number; const1::Number=TFL(0.16)) where {TFL <: Number}
    return (N - R) / (N + R + const1)
end

function OSAVI_func(N::Number, R::Number; const1::Number=TFL(0.16))
    return OSAVI_func(Float64, N::Number, R::Number; const1=const1)
end

indices_funcs["OSAVI"] = OSAVI_func

function AFRI2100_func(::Type{TFL}, N::Number, S2::Number; const1::Number=TFL(0.5), const2::Number=TFL(0.5)) where {TFL <: Number}
    return (N - const1 * S2) / (N + const2 * S2)
end

function AFRI2100_func(N::Number, S2::Number; const1::Number=TFL(0.5), const2::Number=TFL(0.5))
    return AFRI2100_func(Float64, N::Number, S2::Number; const1=const1, const2=const2)
end

indices_funcs["AFRI2100"] = AFRI2100_func

function GNDVI_func(::Type{TFL}, N::Number, G::Number) where {TFL <: Number}
    return (N - G)/(N + G)
end

function GNDVI_func(N::Number, G::Number)
    return GNDVI_func(Float64, N::Number, G::Number)
end

indices_funcs["GNDVI"] = GNDVI_func

function LSWI_func(::Type{TFL}, N::Number, S1::Number) where {TFL <: Number}
    return (N - S1)/(N + S1)
end

function LSWI_func(N::Number, S1::Number)
    return LSWI_func(Float64, N::Number, S1::Number)
end

indices_funcs["LSWI"] = LSWI_func

function UI_func(::Type{TFL}, S2::Number, N::Number) where {TFL <: Number}
    return (S2 - N)/(S2 + N)
end

function UI_func(S2::Number, N::Number)
    return UI_func(Float64, S2::Number, N::Number)
end

indices_funcs["UI"] = UI_func

function S2WI_func(::Type{TFL}, RE1::Number, S2::Number) where {TFL <: Number}
    return (RE1 - S2)/(RE1 + S2)
end

function S2WI_func(RE1::Number, S2::Number)
    return S2WI_func(Float64, RE1::Number, S2::Number)
end

indices_funcs["S2WI"] = S2WI_func

function VIBI_func(::Type{TFL}, N::Number, R::Number, S1::Number) where {TFL <: Number}
    return ((N-R)/(N+R))/(((N-R)/(N+R)) + ((S1-N)/(S1+N)))
end

function VIBI_func(N::Number, R::Number, S1::Number)
    return VIBI_func(Float64, N::Number, R::Number, S1::Number)
end

indices_funcs["VIBI"] = VIBI_func

function NSDSI1_func(::Type{TFL}, S1::Number, S2::Number) where {TFL <: Number}
    return (S1-S2)/S1
end

function NSDSI1_func(S1::Number, S2::Number)
    return NSDSI1_func(Float64, S1::Number, S2::Number)
end

indices_funcs["NSDSI1"] = NSDSI1_func

function VVVHS_func(::Type{TFL}, VV::Number, VH::Number) where {TFL <: Number}
    return VV + VH
end

function VVVHS_func(VV::Number, VH::Number)
    return VVVHS_func(Float64, VV::Number, VH::Number)
end

indices_funcs["VVVHS"] = VVVHS_func

function VI6T_func(::Type{TFL}, N::Number, T::Number; const1::Number=TFL(10000.0), const2::Number=TFL(10000.0)) where {TFL <: Number}
    return (N - T/const1)/(N + T/const2)
end

function VI6T_func(N::Number, T::Number; const1::Number=TFL(10000.0), const2::Number=TFL(10000.0))
    return VI6T_func(Float64, N::Number, T::Number; const1=const1, const2=const2)
end

indices_funcs["VI6T"] = VI6T_func

function kVARI_func(::Type{TFL}, kGG::Number, kGR::Number, kGB::Number) where {TFL <: Number}
    return (kGG - kGR) / (kGG + kGR - kGB)
end

function kVARI_func(kGG::Number, kGR::Number, kGB::Number)
    return kVARI_func(Float64, kGG::Number, kGR::Number, kGB::Number)
end

indices_funcs["kVARI"] = kVARI_func

function BWDRVI_func(::Type{TFL}, alpha::Number, N::Number, B::Number) where {TFL <: Number}
    return (alpha * N - B) / (alpha * N + B)
end

function BWDRVI_func(alpha::Number, N::Number, B::Number)
    return BWDRVI_func(Float64, alpha::Number, N::Number, B::Number)
end

indices_funcs["BWDRVI"] = BWDRVI_func

function BAIM_func(::Type{TFL}, N::Number, S2::Number; const1::Number=TFL(1.0), const2::Number=TFL(0.05), const3::Number=TFL(2.0), const4::Number=TFL(0.2), const5::Number=TFL(2.0)) where {TFL <: Number}
    return const1/((const2 - N) ^ const3) + ((const4 - S2) ^ const5)
end

function BAIM_func(N::Number, S2::Number; const1::Number=TFL(1.0), const2::Number=TFL(0.05), const3::Number=TFL(2.0), const4::Number=TFL(0.2), const5::Number=TFL(2.0))
    return BAIM_func(Float64, N::Number, S2::Number; const1=const1, const2=const2, const3=const3, const4=const4, const5=const5)
end

indices_funcs["BAIM"] = BAIM_func

function VDDPI_func(::Type{TFL}, VV::Number, VH::Number) where {TFL <: Number}
    return (VV + VH)/VV
end

function VDDPI_func(VV::Number, VH::Number)
    return VDDPI_func(Float64, VV::Number, VH::Number)
end

indices_funcs["VDDPI"] = VDDPI_func

function BIXS_func(::Type{TFL}, G::Number, R::Number; const1::Number=TFL(2.0), const2::Number=TFL(2.0), const3::Number=TFL(2.0), const4::Number=TFL(0.5)) where {TFL <: Number}
    return (((G^const1)+(R^const2))/const3)^const4
end

function BIXS_func(G::Number, R::Number; const1::Number=TFL(2.0), const2::Number=TFL(2.0), const3::Number=TFL(2.0), const4::Number=TFL(0.5))
    return BIXS_func(Float64, G::Number, R::Number; const1=const1, const2=const2, const3=const3, const4=const4)
end

indices_funcs["BIXS"] = BIXS_func

function MCARIOSAVI705_func(::Type{TFL}, RE2::Number, RE1::Number, G::Number; const1::Number=TFL(0.2), const2::Number=TFL(1.16), const3::Number=TFL(0.16)) where {TFL <: Number}
    return (((RE2 - RE1) - const1 * (RE2 - G)) * (RE2 / RE1)) / (const2 * (RE2 - RE1) / (RE2 + RE1 + const3))
end

function MCARIOSAVI705_func(RE2::Number, RE1::Number, G::Number; const1::Number=TFL(0.2), const2::Number=TFL(1.16), const3::Number=TFL(0.16))
    return MCARIOSAVI705_func(Float64, RE2::Number, RE1::Number, G::Number; const1=const1, const2=const2, const3=const3)
end

indices_funcs["MCARIOSAVI705"] = MCARIOSAVI705_func

function NDSI_func(::Type{TFL}, G::Number, S1::Number) where {TFL <: Number}
    return (G - S1) / (G + S1)
end

function NDSI_func(G::Number, S1::Number)
    return NDSI_func(Float64, G::Number, S1::Number)
end

indices_funcs["NDSI"] = NDSI_func

function NDVI_func(::Type{TFL}, N::Number, R::Number) where {TFL <: Number}
    return (N - R)/(N + R)
end

function NDVI_func(N::Number, R::Number)
    return NDVI_func(Float64, N::Number, R::Number)
end

indices_funcs["NDVI"] = NDVI_func

function MCARI_func(::Type{TFL}, RE1::Number, R::Number, G::Number; const1::Number=TFL(0.2)) where {TFL <: Number}
    return ((RE1 - R) - const1 * (RE1 - G)) * (RE1 / R)
end

function MCARI_func(RE1::Number, R::Number, G::Number; const1::Number=TFL(0.2))
    return MCARI_func(Float64, RE1::Number, R::Number, G::Number; const1=const1)
end

indices_funcs["MCARI"] = MCARI_func

function MLSWI26_func(::Type{TFL}, N::Number, S1::Number; const1::Number=TFL(1.0), const2::Number=TFL(1.0)) where {TFL <: Number}
    return (const1 - N - S1)/(const2 - N + S1)
end

function MLSWI26_func(N::Number, S1::Number; const1::Number=TFL(1.0), const2::Number=TFL(1.0))
    return MLSWI26_func(Float64, N::Number, S1::Number; const1=const1, const2=const2)
end

indices_funcs["MLSWI26"] = MLSWI26_func

function VgNIRBI_func(::Type{TFL}, G::Number, N::Number) where {TFL <: Number}
    return (G - N)/(G + N)
end

function VgNIRBI_func(G::Number, N::Number)
    return VgNIRBI_func(Float64, G::Number, N::Number)
end

indices_funcs["VgNIRBI"] = VgNIRBI_func

function TCARIOSAVI_func(::Type{TFL}, RE1::Number, R::Number, G::Number, N::Number; const1::Number=TFL(3), const2::Number=TFL(0.2), const3::Number=TFL(1.16), const4::Number=TFL(0.16)) where {TFL <: Number}
    return (const1 * ((RE1 - R) - const2 * (RE1 - G) * (RE1 / R))) / (const3 * (N - R) / (N + R + const4))
end

function TCARIOSAVI_func(RE1::Number, R::Number, G::Number, N::Number; const1::Number=TFL(3), const2::Number=TFL(0.2), const3::Number=TFL(1.16), const4::Number=TFL(0.16))
    return TCARIOSAVI_func(Float64, RE1::Number, R::Number, G::Number, N::Number; const1=const1, const2=const2, const3=const3, const4=const4)
end

indices_funcs["TCARIOSAVI"] = TCARIOSAVI_func

function AVI_func(::Type{TFL}, N::Number, R::Number; const1::Number=TFL(1.0), const2::Number=TFL(1), const3::Number=TFL(3)) where {TFL <: Number}
    return (N * (const1 - R) * (N - R)) ^ (const2/const3)
end

function AVI_func(N::Number, R::Number; const1::Number=TFL(1.0), const2::Number=TFL(1), const3::Number=TFL(3))
    return AVI_func(Float64, N::Number, R::Number; const1=const1, const2=const2, const3=const3)
end

indices_funcs["AVI"] = AVI_func

function NormR_func(::Type{TFL}, R::Number, N::Number, G::Number) where {TFL <: Number}
    return R/(N + G + R)
end

function NormR_func(R::Number, N::Number, G::Number)
    return NormR_func(Float64, R::Number, N::Number, G::Number)
end

indices_funcs["NormR"] = NormR_func

function VHVVP_func(::Type{TFL}, VH::Number, VV::Number) where {TFL <: Number}
    return VH * VV
end

function VHVVP_func(VH::Number, VV::Number)
    return VHVVP_func(Float64, VH::Number, VV::Number)
end

indices_funcs["VHVVP"] = VHVVP_func

function NSDS_func(::Type{TFL}, S1::Number, S2::Number) where {TFL <: Number}
    return (S1 - S2)/(S1 + S2)
end

function NSDS_func(S1::Number, S2::Number)
    return NSDS_func(Float64, S1::Number, S2::Number)
end

indices_funcs["NSDS"] = NSDS_func

function NDSWIR_func(::Type{TFL}, N::Number, S1::Number) where {TFL <: Number}
    return (N - S1)/(N + S1)
end

function NDSWIR_func(N::Number, S1::Number)
    return NDSWIR_func(Float64, N::Number, S1::Number)
end

indices_funcs["NDSWIR"] = NDSWIR_func

function REDSI_func(::Type{TFL}, RE3::Number, R::Number, RE1::Number; const1::Number=TFL(705.0), const2::Number=TFL(665.0), const3::Number=TFL(783.0), const4::Number=TFL(665.0), const5::Number=TFL(2.0)) where {TFL <: Number}
    return ((const1 - const2) * (RE3 - R) - (const3 - const4) * (RE1 - R)) / (const5 * R)
end

function REDSI_func(RE3::Number, R::Number, RE1::Number; const1::Number=TFL(705.0), const2::Number=TFL(665.0), const3::Number=TFL(783.0), const4::Number=TFL(665.0), const5::Number=TFL(2.0))
    return REDSI_func(Float64, RE3::Number, R::Number, RE1::Number; const1=const1, const2=const2, const3=const3, const4=const4, const5=const5)
end

indices_funcs["REDSI"] = REDSI_func

function DBI_func(::Type{TFL}, B::Number, T1::Number, N::Number, R::Number) where {TFL <: Number}
    return ((B - T1)/(B + T1)) - ((N - R)/(N + R))
end

function DBI_func(B::Number, T1::Number, N::Number, R::Number)
    return DBI_func(Float64, B::Number, T1::Number, N::Number, R::Number)
end

indices_funcs["DBI"] = DBI_func

function ND705_func(::Type{TFL}, RE2::Number, RE1::Number) where {TFL <: Number}
    return (RE2 - RE1)/(RE2 + RE1)
end

function ND705_func(RE2::Number, RE1::Number)
    return ND705_func(Float64, RE2::Number, RE1::Number)
end

indices_funcs["ND705"] = ND705_func

function MNDWI_func(::Type{TFL}, G::Number, S1::Number) where {TFL <: Number}
    return (G - S1) / (G + S1)
end

function MNDWI_func(G::Number, S1::Number)
    return MNDWI_func(Float64, G::Number, S1::Number)
end

indices_funcs["MNDWI"] = MNDWI_func

function RGBVI_func(::Type{TFL}, G::Number, B::Number, R::Number; const1::Number=TFL(2.0), const2::Number=TFL(2.0)) where {TFL <: Number}
    return (G ^ const1 - B * R)/(G ^ const2 + B * R)
end

function RGBVI_func(G::Number, B::Number, R::Number; const1::Number=TFL(2.0), const2::Number=TFL(2.0))
    return RGBVI_func(Float64, G::Number, B::Number, R::Number; const1=const1, const2=const2)
end

indices_funcs["RGBVI"] = RGBVI_func

function MSI_func(::Type{TFL}, S1::Number, N::Number) where {TFL <: Number}
    return S1/N
end

function MSI_func(S1::Number, N::Number)
    return MSI_func(Float64, S1::Number, N::Number)
end

indices_funcs["MSI"] = MSI_func

function RGRI_func(::Type{TFL}, R::Number, G::Number) where {TFL <: Number}
    return R/G
end

function RGRI_func(R::Number, G::Number)
    return RGRI_func(Float64, R::Number, G::Number)
end

indices_funcs["RGRI"] = RGRI_func

function GRVI_func(::Type{TFL}, N::Number, G::Number) where {TFL <: Number}
    return N/G
end

function GRVI_func(N::Number, G::Number)
    return GRVI_func(Float64, N::Number, G::Number)
end

indices_funcs["GRVI"] = GRVI_func

function VARI_func(::Type{TFL}, G::Number, R::Number, B::Number) where {TFL <: Number}
    return (G - R) / (G + R - B)
end

function VARI_func(G::Number, R::Number, B::Number)
    return VARI_func(Float64, G::Number, R::Number, B::Number)
end

indices_funcs["VARI"] = VARI_func

function NMDI_func(::Type{TFL}, N::Number, S1::Number, S2::Number) where {TFL <: Number}
    return (N - (S1 - S2))/(N + (S1 - S2))
end

function NMDI_func(N::Number, S1::Number, S2::Number)
    return NMDI_func(Float64, N::Number, S1::Number, S2::Number)
end

indices_funcs["NMDI"] = NMDI_func

function RENDVI_func(::Type{TFL}, RE2::Number, RE1::Number) where {TFL <: Number}
    return (RE2 - RE1)/(RE2 + RE1)
end

function RENDVI_func(RE2::Number, RE1::Number)
    return RENDVI_func(Float64, RE2::Number, RE1::Number)
end

indices_funcs["RENDVI"] = RENDVI_func

function NSDSI2_func(::Type{TFL}, S1::Number, S2::Number) where {TFL <: Number}
    return (S1-S2)/S2
end

function NSDSI2_func(S1::Number, S2::Number)
    return NSDSI2_func(Float64, S1::Number, S2::Number)
end

indices_funcs["NSDSI2"] = NSDSI2_func

function TCARI_func(::Type{TFL}, RE1::Number, R::Number, G::Number; const1::Number=TFL(3), const2::Number=TFL(0.2)) where {TFL <: Number}
    return const1 * ((RE1 - R) - const2 * (RE1 - G) * (RE1 / R))
end

function TCARI_func(RE1::Number, R::Number, G::Number; const1::Number=TFL(3), const2::Number=TFL(0.2))
    return TCARI_func(Float64, RE1::Number, R::Number, G::Number; const1=const1, const2=const2)
end

indices_funcs["TCARI"] = TCARI_func

function kEVI_func(::Type{TFL}, g::Number, kNN::Number, kNR::Number, C1::Number, C2::Number, kNB::Number, kNL::Number) where {TFL <: Number}
    return g * (kNN - kNR) / (kNN + C1 * kNR - C2 * kNB + kNL)
end

function kEVI_func(g::Number, kNN::Number, kNR::Number, C1::Number, C2::Number, kNB::Number, kNL::Number)
    return kEVI_func(Float64, g::Number, kNN::Number, kNR::Number, C1::Number, C2::Number, kNB::Number, kNL::Number)
end

indices_funcs["kEVI"] = kEVI_func

function ARI2_func(::Type{TFL}, N::Number, G::Number, RE1::Number; const1::Number=TFL(1), const2::Number=TFL(1)) where {TFL <: Number}
    return N * ((const1 / G) - (const2 / RE1))
end

function ARI2_func(N::Number, G::Number, RE1::Number; const1::Number=TFL(1), const2::Number=TFL(1))
    return ARI2_func(Float64, N::Number, G::Number, RE1::Number; const1=const1, const2=const2)
end

indices_funcs["ARI2"] = ARI2_func

function GM1_func(::Type{TFL}, RE2::Number, G::Number) where {TFL <: Number}
    return RE2/G
end

function GM1_func(RE2::Number, G::Number)
    return GM1_func(Float64, RE2::Number, G::Number)
end

indices_funcs["GM1"] = GM1_func

function SLAVI_func(::Type{TFL}, N::Number, R::Number, S2::Number) where {TFL <: Number}
    return N/(R + S2)
end

function SLAVI_func(N::Number, R::Number, S2::Number)
    return SLAVI_func(Float64, N::Number, R::Number, S2::Number)
end

indices_funcs["SLAVI"] = SLAVI_func

function GVMI_func(::Type{TFL}, N::Number, S2::Number; const1::Number=TFL(0.1), const2::Number=TFL(0.02), const3::Number=TFL(0.1), const4::Number=TFL(0.02)) where {TFL <: Number}
    return ((N + const1) - (S2 + const2)) / ((N + const3) + (S2 + const4))
end

function GVMI_func(N::Number, S2::Number; const1::Number=TFL(0.1), const2::Number=TFL(0.02), const3::Number=TFL(0.1), const4::Number=TFL(0.02))
    return GVMI_func(Float64, N::Number, S2::Number; const1=const1, const2=const2, const3=const3, const4=const4)
end

indices_funcs["GVMI"] = GVMI_func

function NBSIMS_func(::Type{TFL}, G::Number, R::Number, N::Number, B::Number, S2::Number, S1::Number; const1::Number=TFL(0.36)) where {TFL <: Number}
    return const1 * (G + R + N) - (((B + S2)/G) + S1)
end

function NBSIMS_func(G::Number, R::Number, N::Number, B::Number, S2::Number, S1::Number; const1::Number=TFL(0.36))
    return NBSIMS_func(Float64, G::Number, R::Number, N::Number, B::Number, S2::Number, S1::Number; const1=const1)
end

indices_funcs["NBSIMS"] = NBSIMS_func

function NBLIOLI_func(::Type{TFL}, R::Number, T1::Number) where {TFL <: Number}
    return (R - T1)/(R + T1)
end

function NBLIOLI_func(R::Number, T1::Number)
    return NBLIOLI_func(Float64, R::Number, T1::Number)
end

indices_funcs["NBLIOLI"] = NBLIOLI_func

function AWEIsh_func(::Type{TFL}, B::Number, G::Number, N::Number, S1::Number, S2::Number; const1::Number=TFL(2.5), const2::Number=TFL(1.5), const3::Number=TFL(0.25)) where {TFL <: Number}
    return B + const1 * G - const2 * (N + S1) - const3 * S2
end

function AWEIsh_func(B::Number, G::Number, N::Number, S1::Number, S2::Number; const1::Number=TFL(2.5), const2::Number=TFL(1.5), const3::Number=TFL(0.25))
    return AWEIsh_func(Float64, B::Number, G::Number, N::Number, S1::Number, S2::Number; const1=const1, const2=const2, const3=const3)
end

indices_funcs["AWEIsh"] = AWEIsh_func

function RFDI_func(::Type{TFL}, HH::Number, HV::Number) where {TFL <: Number}
    return (HH - HV)/(HH + HV)
end

function RFDI_func(HH::Number, HV::Number)
    return RFDI_func(Float64, HH::Number, HV::Number)
end

indices_funcs["RFDI"] = RFDI_func

function SIPI_func(::Type{TFL}, N::Number, A::Number, R::Number) where {TFL <: Number}
    return (N - A) / (N - R)
end

function SIPI_func(N::Number, A::Number, R::Number)
    return SIPI_func(Float64, N::Number, A::Number, R::Number)
end

indices_funcs["SIPI"] = SIPI_func

function DpRVIHH_func(::Type{TFL}, HV::Number, HH::Number; const1::Number=TFL(4.0)) where {TFL <: Number}
    return (const1 * HV)/(HH + HV)
end

function DpRVIHH_func(HV::Number, HH::Number; const1::Number=TFL(4.0))
    return DpRVIHH_func(Float64, HV::Number, HH::Number; const1=const1)
end

indices_funcs["DpRVIHH"] = DpRVIHH_func

function NDISImndwi_func(::Type{TFL}, T::Number, G::Number, S1::Number, N::Number; const1::Number=TFL(3.0), const2::Number=TFL(3.0)) where {TFL <: Number}
    return (T - (((G - S1)/(G + S1)) + N + S1) / const1)/(T + (((G - S1)/(G + S1)) + N + S1) / const2)
end

function NDISImndwi_func(T::Number, G::Number, S1::Number, N::Number; const1::Number=TFL(3.0), const2::Number=TFL(3.0))
    return NDISImndwi_func(Float64, T::Number, G::Number, S1::Number, N::Number; const1=const1, const2=const2)
end

indices_funcs["NDISImndwi"] = NDISImndwi_func

function MBWI_func(::Type{TFL}, omega::Number, G::Number, R::Number, N::Number, S1::Number, S2::Number) where {TFL <: Number}
    return (omega * G) - R - N - S1 - S2
end

function MBWI_func(omega::Number, G::Number, R::Number, N::Number, S1::Number, S2::Number)
    return MBWI_func(Float64, omega::Number, G::Number, R::Number, N::Number, S1::Number, S2::Number)
end

indices_funcs["MBWI"] = MBWI_func

function GM2_func(::Type{TFL}, RE2::Number, RE1::Number) where {TFL <: Number}
    return RE2/RE1
end

function GM2_func(RE2::Number, RE1::Number)
    return GM2_func(Float64, RE2::Number, RE1::Number)
end

indices_funcs["GM2"] = GM2_func

function VVVHD_func(::Type{TFL}, VV::Number, VH::Number) where {TFL <: Number}
    return VV - VH
end

function VVVHD_func(VV::Number, VH::Number)
    return VVVHD_func(Float64, VV::Number, VH::Number)
end

indices_funcs["VVVHD"] = VVVHD_func

function VrNIRBI_func(::Type{TFL}, R::Number, N::Number) where {TFL <: Number}
    return (R - N)/(R + N)
end

function VrNIRBI_func(R::Number, N::Number)
    return VrNIRBI_func(Float64, R::Number, N::Number)
end

indices_funcs["VrNIRBI"] = VrNIRBI_func

function SEVI_func(::Type{TFL}, N::Number, R::Number, fdelta::Number; const1::Number=TFL(1.0)) where {TFL <: Number}
    return (N/R) + fdelta * (const1/R)
end

function SEVI_func(N::Number, R::Number, fdelta::Number; const1::Number=TFL(1.0))
    return SEVI_func(Float64, N::Number, R::Number, fdelta::Number; const1=const1)
end

indices_funcs["SEVI"] = SEVI_func

function NSTv1_func(::Type{TFL}, N::Number, S2::Number, T::Number) where {TFL <: Number}
    return ((N-S2)/(N+S2))*T
end

function NSTv1_func(N::Number, S2::Number, T::Number)
    return NSTv1_func(Float64, N::Number, S2::Number, T::Number)
end

indices_funcs["NSTv1"] = NSTv1_func

function NDISIndwi_func(::Type{TFL}, T::Number, G::Number, N::Number, S1::Number; const1::Number=TFL(3.0), const2::Number=TFL(3.0)) where {TFL <: Number}
    return (T - (((G - N)/(G + N)) + N + S1) / const1)/(T + (((G - N)/(G + N)) + N + S1) / const2)
end

function NDISIndwi_func(T::Number, G::Number, N::Number, S1::Number; const1::Number=TFL(3.0), const2::Number=TFL(3.0))
    return NDISIndwi_func(Float64, T::Number, G::Number, N::Number, S1::Number; const1=const1, const2=const2)
end

indices_funcs["NDISIndwi"] = NDISIndwi_func

function NDGlaI_func(::Type{TFL}, G::Number, R::Number) where {TFL <: Number}
    return (G - R)/(G + R)
end

function NDGlaI_func(G::Number, R::Number)
    return NDGlaI_func(Float64, G::Number, R::Number)
end

indices_funcs["NDGlaI"] = NDGlaI_func

function GBNDVI_func(::Type{TFL}, N::Number, G::Number, B::Number) where {TFL <: Number}
    return (N - (G + B))/(N + (G + B))
end

function GBNDVI_func(N::Number, G::Number, B::Number)
    return GBNDVI_func(Float64, N::Number, G::Number, B::Number)
end

indices_funcs["GBNDVI"] = GBNDVI_func

function BRBA_func(::Type{TFL}, R::Number, S1::Number) where {TFL <: Number}
    return R/S1
end

function BRBA_func(R::Number, S1::Number)
    return BRBA_func(Float64, R::Number, S1::Number)
end

indices_funcs["BRBA"] = BRBA_func

function CSI_func(::Type{TFL}, N::Number, S2::Number) where {TFL <: Number}
    return N/S2
end

function CSI_func(N::Number, S2::Number)
    return CSI_func(Float64, N::Number, S2::Number)
end

indices_funcs["CSI"] = CSI_func

function NDVIT_func(::Type{TFL}, N::Number, R::Number, T::Number; const1::Number=TFL(10000.0), const2::Number=TFL(10000.0)) where {TFL <: Number}
    return (N - (R * T / const1))/(N + (R * T / const2))
end

function NDVIT_func(N::Number, R::Number, T::Number; const1::Number=TFL(10000.0), const2::Number=TFL(10000.0))
    return NDVIT_func(Float64, N::Number, R::Number, T::Number; const1=const1, const2=const2)
end

indices_funcs["NDVIT"] = NDVIT_func

function MNDVI_func(::Type{TFL}, N::Number, S2::Number) where {TFL <: Number}
    return (N - S2)/(N + S2)
end

function MNDVI_func(N::Number, S2::Number)
    return MNDVI_func(Float64, N::Number, S2::Number)
end

indices_funcs["MNDVI"] = MNDVI_func

function BAI_func(::Type{TFL}, R::Number, N::Number; const1::Number=TFL(1.0), const2::Number=TFL(0.1), const3::Number=TFL(2.0), const4::Number=TFL(0.06), const5::Number=TFL(2.0)) where {TFL <: Number}
    return const1 / ((const2 - R) ^ const3 + (const4 - N) ^ const5)
end

function BAI_func(R::Number, N::Number; const1::Number=TFL(1.0), const2::Number=TFL(0.1), const3::Number=TFL(2.0), const4::Number=TFL(0.06), const5::Number=TFL(2.0))
    return BAI_func(Float64, R::Number, N::Number; const1=const1, const2=const2, const3=const3, const4=const4, const5=const5)
end

indices_funcs["BAI"] = BAI_func

function TRRVI_func(::Type{TFL}, RE2::Number, R::Number, N::Number; const1::Number=TFL(1.0)) where {TFL <: Number}
    return ((RE2 - R) / (RE2 + R)) / (((N - R) / (N + R)) + const1)
end

function TRRVI_func(RE2::Number, R::Number, N::Number; const1::Number=TFL(1.0))
    return TRRVI_func(Float64, RE2::Number, R::Number, N::Number; const1=const1)
end

indices_funcs["TRRVI"] = TRRVI_func

function EVI_func(::Type{TFL}, g::Number, N::Number, R::Number, C1::Number, C2::Number, B::Number, L::Number) where {TFL <: Number}
    return g * (N - R) / (N + C1 * R - C2 * B + L)
end

function EVI_func(g::Number, N::Number, R::Number, C1::Number, C2::Number, B::Number, L::Number)
    return EVI_func(Float64, g::Number, N::Number, R::Number, C1::Number, C2::Number, B::Number, L::Number)
end

indices_funcs["EVI"] = EVI_func

function DBSI_func(::Type{TFL}, S1::Number, G::Number, N::Number, R::Number) where {TFL <: Number}
    return ((S1 - G)/(S1 + G)) - ((N - R)/(N + R))
end

function DBSI_func(S1::Number, G::Number, N::Number, R::Number)
    return DBSI_func(Float64, S1::Number, G::Number, N::Number, R::Number)
end

indices_funcs["DBSI"] = DBSI_func

function NDPonI_func(::Type{TFL}, S1::Number, G::Number) where {TFL <: Number}
    return (S1-G)/(S1+G)
end

function NDPonI_func(S1::Number, G::Number)
    return NDPonI_func(Float64, S1::Number, G::Number)
end

indices_funcs["NDPonI"] = NDPonI_func

function NLI_func(::Type{TFL}, N::Number, R::Number; const1::Number=TFL(2), const2::Number=TFL(2)) where {TFL <: Number}
    return ((N ^ const1) - R)/((N ^ const2) + R)
end

function NLI_func(N::Number, R::Number; const1::Number=TFL(2), const2::Number=TFL(2))
    return NLI_func(Float64, N::Number, R::Number; const1=const1, const2=const2)
end

indices_funcs["NLI"] = NLI_func

function NDSaII_func(::Type{TFL}, R::Number, S1::Number) where {TFL <: Number}
    return (R - S1) / (R + S1)
end

function NDSaII_func(R::Number, S1::Number)
    return NDSaII_func(Float64, R::Number, S1::Number)
end

indices_funcs["NDSaII"] = NDSaII_func

function MSR705_func(::Type{TFL}, RE2::Number, RE1::Number; const1::Number=TFL(1), const2::Number=TFL(1), const3::Number=TFL(0.5)) where {TFL <: Number}
    return (RE2 / RE1 - const1) / ((RE2 / RE1 + const2) ^ const3)
end

function MSR705_func(RE2::Number, RE1::Number; const1::Number=TFL(1), const2::Number=TFL(1), const3::Number=TFL(0.5))
    return MSR705_func(Float64, RE2::Number, RE1::Number; const1=const1, const2=const2, const3=const3)
end

indices_funcs["MSR705"] = MSR705_func

function MTVI1_func(::Type{TFL}, N::Number, G::Number, R::Number; const1::Number=TFL(1.2), const2::Number=TFL(1.2), const3::Number=TFL(2.5)) where {TFL <: Number}
    return const1 * (const2 * (N - G) - const3 * (R - G))
end

function MTVI1_func(N::Number, G::Number, R::Number; const1::Number=TFL(1.2), const2::Number=TFL(1.2), const3::Number=TFL(2.5))
    return MTVI1_func(Float64, N::Number, G::Number, R::Number; const1=const1, const2=const2, const3=const3)
end

indices_funcs["MTVI1"] = MTVI1_func

function IKAW_func(::Type{TFL}, R::Number, B::Number) where {TFL <: Number}
    return (R - B)/(R + B)
end

function IKAW_func(R::Number, B::Number)
    return IKAW_func(Float64, R::Number, B::Number)
end

indices_funcs["IKAW"] = IKAW_func

function MIRBI_func(::Type{TFL}, S2::Number, S1::Number; const1::Number=TFL(10.0), const2::Number=TFL(9.8), const3::Number=TFL(2.0)) where {TFL <: Number}
    return const1 * S2 - const2 * S1 + const3
end

function MIRBI_func(S2::Number, S1::Number; const1::Number=TFL(10.0), const2::Number=TFL(9.8), const3::Number=TFL(2.0))
    return MIRBI_func(Float64, S2::Number, S1::Number; const1=const1, const2=const2, const3=const3)
end

indices_funcs["MIRBI"] = MIRBI_func

function CSIT_func(::Type{TFL}, N::Number, S2::Number, T::Number; const1::Number=TFL(10000.0)) where {TFL <: Number}
    return N / (S2 * T / const1)
end

function CSIT_func(N::Number, S2::Number, T::Number; const1::Number=TFL(10000.0))
    return CSIT_func(Float64, N::Number, S2::Number, T::Number; const1=const1)
end

indices_funcs["CSIT"] = CSIT_func

function TDVI_func(::Type{TFL}, N::Number, R::Number; const1::Number=TFL(1.5), const2::Number=TFL(2.0), const3::Number=TFL(0.5), const4::Number=TFL(0.5)) where {TFL <: Number}
    return const1 * ((N - R)/((N ^ const2 + R + const3) ^ const4))
end

function TDVI_func(N::Number, R::Number; const1::Number=TFL(1.5), const2::Number=TFL(2.0), const3::Number=TFL(0.5), const4::Number=TFL(0.5))
    return TDVI_func(Float64, N::Number, R::Number; const1=const1, const2=const2, const3=const3, const4=const4)
end

indices_funcs["TDVI"] = TDVI_func

function DSWI2_func(::Type{TFL}, S1::Number, G::Number) where {TFL <: Number}
    return S1/G
end

function DSWI2_func(S1::Number, G::Number)
    return DSWI2_func(Float64, S1::Number, G::Number)
end

indices_funcs["DSWI2"] = DSWI2_func

function CIRE_func(::Type{TFL}, N::Number, RE1::Number; const1::Number=TFL(1)) where {TFL <: Number}
    return (N / RE1) - const1
end

function CIRE_func(N::Number, RE1::Number; const1::Number=TFL(1))
    return CIRE_func(Float64, N::Number, RE1::Number; const1=const1)
end

indices_funcs["CIRE"] = CIRE_func

function NDISIr_func(::Type{TFL}, T::Number, R::Number, N::Number, S1::Number; const1::Number=TFL(3.0), const2::Number=TFL(3.0)) where {TFL <: Number}
    return (T - (R + N + S1) / const1)/(T + (R + N + S1) / const2)
end

function NDISIr_func(T::Number, R::Number, N::Number, S1::Number; const1::Number=TFL(3.0), const2::Number=TFL(3.0))
    return NDISIr_func(Float64, T::Number, R::Number, N::Number, S1::Number; const1=const1, const2=const2)
end

indices_funcs["NDISIr"] = NDISIr_func

function NDDI_func(::Type{TFL}, N::Number, R::Number, G::Number) where {TFL <: Number}
    return (((N - R)/(N + R)) - ((G - N)/(G + N)))/(((N - R)/(N + R)) + ((G - N)/(G + N)))
end

function NDDI_func(N::Number, R::Number, G::Number)
    return NDDI_func(Float64, N::Number, R::Number, G::Number)
end

indices_funcs["NDDI"] = NDDI_func

function NDREI_func(::Type{TFL}, N::Number, RE1::Number) where {TFL <: Number}
    return (N - RE1) / (N + RE1)
end

function NDREI_func(N::Number, RE1::Number)
    return NDREI_func(Float64, N::Number, RE1::Number)
end

indices_funcs["NDREI"] = NDREI_func

function NDTI_func(::Type{TFL}, R::Number, G::Number) where {TFL <: Number}
    return (R-G)/(R+G)
end

function NDTI_func(R::Number, G::Number)
    return NDTI_func(Float64, R::Number, G::Number)
end

indices_funcs["NDTI"] = NDTI_func

function QpRVI_func(::Type{TFL}, HV::Number, HH::Number, VV::Number; const1::Number=TFL(8.0), const2::Number=TFL(2.0)) where {TFL <: Number}
    return (const1 * HV)/(HH + VV + const2 * HV)
end

function QpRVI_func(HV::Number, HH::Number, VV::Number; const1::Number=TFL(8.0), const2::Number=TFL(2.0))
    return QpRVI_func(Float64, HV::Number, HH::Number, VV::Number; const1=const1, const2=const2)
end

indices_funcs["QpRVI"] = QpRVI_func

function DSWI1_func(::Type{TFL}, N::Number, S1::Number) where {TFL <: Number}
    return N/S1
end

function DSWI1_func(N::Number, S1::Number)
    return DSWI1_func(Float64, N::Number, S1::Number)
end

indices_funcs["DSWI1"] = DSWI1_func

function EBBI_func(::Type{TFL}, S1::Number, N::Number, T::Number; const1::Number=TFL(10.0), const2::Number=TFL(0.5)) where {TFL <: Number}
    return (S1 - N) / (const1 * ((S1 + T) ^ const2))
end

function EBBI_func(S1::Number, N::Number, T::Number; const1::Number=TFL(10.0), const2::Number=TFL(0.5))
    return EBBI_func(Float64, S1::Number, N::Number, T::Number; const1=const1, const2=const2)
end

indices_funcs["EBBI"] = EBBI_func

function MCARI1_func(::Type{TFL}, N::Number, R::Number, G::Number; const1::Number=TFL(1.2), const2::Number=TFL(2.5), const3::Number=TFL(1.3)) where {TFL <: Number}
    return const1 * (const2 * (N - R) - const3 * (N - G))
end

function MCARI1_func(N::Number, R::Number, G::Number; const1::Number=TFL(1.2), const2::Number=TFL(2.5), const3::Number=TFL(1.3))
    return MCARI1_func(Float64, N::Number, R::Number, G::Number; const1=const1, const2=const2, const3=const3)
end

indices_funcs["MCARI1"] = MCARI1_func

function BNDVI_func(::Type{TFL}, N::Number, B::Number) where {TFL <: Number}
    return (N - B)/(N + B)
end

function BNDVI_func(N::Number, B::Number)
    return BNDVI_func(Float64, N::Number, B::Number)
end

indices_funcs["BNDVI"] = BNDVI_func

function NDSII_func(::Type{TFL}, G::Number, N::Number) where {TFL <: Number}
    return (G - N)/(G + N)
end

function NDSII_func(G::Number, N::Number)
    return NDSII_func(Float64, G::Number, N::Number)
end

indices_funcs["NDSII"] = NDSII_func

function NIRvH2_func(::Type{TFL}, N::Number, R::Number, k::Number, lambdaN::Number, lambdaR::Number) where {TFL <: Number}
    return N - R - k * (lambdaN - lambdaR)
end

function NIRvH2_func(N::Number, R::Number, k::Number, lambdaN::Number, lambdaR::Number)
    return NIRvH2_func(Float64, N::Number, R::Number, k::Number, lambdaN::Number, lambdaR::Number)
end

indices_funcs["NIRvH2"] = NIRvH2_func

function NBRT2_func(::Type{TFL}, N::Number, T::Number, S2::Number; const1::Number=TFL(10000.0), const2::Number=TFL(10000.0)) where {TFL <: Number}
    return ((N / (T / const1)) - S2) / ((N / (T / const2)) + S2)
end

function NBRT2_func(N::Number, T::Number, S2::Number; const1::Number=TFL(10000.0), const2::Number=TFL(10000.0))
    return NBRT2_func(Float64, N::Number, T::Number, S2::Number; const1=const1, const2=const2)
end

indices_funcs["NBRT2"] = NBRT2_func

function DVIplus_func(::Type{TFL}, lambdaN::Number, lambdaR::Number, lambdaG::Number, G::Number, N::Number, R::Number; const1::Number=TFL(1.0)) where {TFL <: Number}
    return ((lambdaN - lambdaR)/(lambdaN - lambdaG)) * G + (const1 - ((lambdaN - lambdaR)/(lambdaN - lambdaG))) * N - R
end

function DVIplus_func(lambdaN::Number, lambdaR::Number, lambdaG::Number, G::Number, N::Number, R::Number; const1::Number=TFL(1.0))
    return DVIplus_func(Float64, lambdaN::Number, lambdaR::Number, lambdaG::Number, G::Number, N::Number, R::Number; const1=const1)
end

indices_funcs["DVIplus"] = DVIplus_func

function CVI_func(::Type{TFL}, N::Number, R::Number, G::Number; const1::Number=TFL(2.0)) where {TFL <: Number}
    return (N * R) / (G ^ const1)
end

function CVI_func(N::Number, R::Number, G::Number; const1::Number=TFL(2.0))
    return CVI_func(Float64, N::Number, R::Number, G::Number; const1=const1)
end

indices_funcs["CVI"] = CVI_func

function RI4XS_func(::Type{TFL}, R::Number, G::Number; const1::Number=TFL(2.0), const2::Number=TFL(4.0)) where {TFL <: Number}
    return (R^const1)/(G^const2)
end

function RI4XS_func(R::Number, G::Number; const1::Number=TFL(2.0), const2::Number=TFL(4.0))
    return RI4XS_func(Float64, R::Number, G::Number; const1=const1, const2=const2)
end

indices_funcs["RI4XS"] = RI4XS_func

function kRVI_func(::Type{TFL}, kNN::Number, kNR::Number) where {TFL <: Number}
    return kNN / kNR
end

function kRVI_func(kNN::Number, kNR::Number)
    return kRVI_func(Float64, kNN::Number, kNR::Number)
end

indices_funcs["kRVI"] = kRVI_func

function AFRI1600_func(::Type{TFL}, N::Number, S1::Number; const1::Number=TFL(0.66), const2::Number=TFL(0.66)) where {TFL <: Number}
    return (N - const1 * S1) / (N + const2 * S1)
end

function AFRI1600_func(N::Number, S1::Number; const1::Number=TFL(0.66), const2::Number=TFL(0.66))
    return AFRI1600_func(Float64, N::Number, S1::Number; const1=const1, const2=const2)
end

indices_funcs["AFRI1600"] = AFRI1600_func

function SR705_func(::Type{TFL}, RE2::Number, RE1::Number) where {TFL <: Number}
    return RE2 / RE1
end

function SR705_func(RE2::Number, RE1::Number)
    return SR705_func(Float64, RE2::Number, RE1::Number)
end

indices_funcs["SR705"] = SR705_func

function IBI_func(::Type{TFL}, S1::Number, N::Number, R::Number, L::Number, G::Number; const1::Number=TFL(1.0), const2::Number=TFL(2.0), const3::Number=TFL(1.0), const4::Number=TFL(2.0)) where {TFL <: Number}
    return (((S1-N)/(S1+N))-(((N-R)*(const1+L)/(N+R+L))+((G-S1)/(G+S1)))/const2)/(((S1-N)/(S1+N))+(((N-R)*(const3+L)/(N+R+L))+((G-S1)/(G+S1)))/const4)
end

function IBI_func(S1::Number, N::Number, R::Number, L::Number, G::Number; const1::Number=TFL(1.0), const2::Number=TFL(2.0), const3::Number=TFL(1.0), const4::Number=TFL(2.0))
    return IBI_func(Float64, S1::Number, N::Number, R::Number, L::Number, G::Number; const1=const1, const2=const2, const3=const3, const4=const4)
end

indices_funcs["IBI"] = IBI_func

function VARI700_func(::Type{TFL}, RE1::Number, R::Number, B::Number; const1::Number=TFL(1.7), const2::Number=TFL(0.7), const3::Number=TFL(1.3), const4::Number=TFL(1.3)) where {TFL <: Number}
    return (RE1 - const1 * R + const2 * B) / (RE1 + const3 * R - const4 * B)
end

function VARI700_func(RE1::Number, R::Number, B::Number; const1::Number=TFL(1.7), const2::Number=TFL(0.7), const3::Number=TFL(1.3), const4::Number=TFL(1.3))
    return VARI700_func(Float64, RE1::Number, R::Number, B::Number; const1=const1, const2=const2, const3=const3, const4=const4)
end

indices_funcs["VARI700"] = VARI700_func

function NBLI_func(::Type{TFL}, R::Number, T::Number) where {TFL <: Number}
    return (R - T)/(R + T)
end

function NBLI_func(R::Number, T::Number)
    return NBLI_func(Float64, R::Number, T::Number)
end

indices_funcs["NBLI"] = NBLI_func

function NDII_func(::Type{TFL}, N::Number, S1::Number) where {TFL <: Number}
    return (N - S1)/(N + S1)
end

function NDII_func(N::Number, S1::Number)
    return NDII_func(Float64, N::Number, S1::Number)
end

indices_funcs["NDII"] = NDII_func

function S2REP_func(::Type{TFL}, RE3::Number, R::Number, RE1::Number, RE2::Number; const1::Number=TFL(705.0), const2::Number=TFL(35.0), const3::Number=TFL(2.0)) where {TFL <: Number}
    return const1 + const2 * ((((RE3 + R) / const3) - RE1) / (RE2 - RE1))
end

function S2REP_func(RE3::Number, R::Number, RE1::Number, RE2::Number; const1::Number=TFL(705.0), const2::Number=TFL(35.0), const3::Number=TFL(2.0))
    return S2REP_func(Float64, RE3::Number, R::Number, RE1::Number, RE2::Number; const1=const1, const2=const2, const3=const3)
end

indices_funcs["S2REP"] = S2REP_func

function NDMI_func(::Type{TFL}, N::Number, S1::Number) where {TFL <: Number}
    return (N - S1)/(N + S1)
end

function NDMI_func(N::Number, S1::Number)
    return NDMI_func(Float64, N::Number, S1::Number)
end

indices_funcs["NDMI"] = NDMI_func

function NBUI_func(::Type{TFL}, S1::Number, N::Number, T::Number, R::Number, L::Number, G::Number; const1::Number=TFL(10.0), const2::Number=TFL(0.5), const3::Number=TFL(1.0)) where {TFL <: Number}
    return ((S1 - N)/(const1 * (T + S1) ^ const2)) - (((N - R) * (const3 + L))/(N - R + L)) - (G - S1)/(G + S1)
end

function NBUI_func(S1::Number, N::Number, T::Number, R::Number, L::Number, G::Number; const1::Number=TFL(10.0), const2::Number=TFL(0.5), const3::Number=TFL(1.0))
    return NBUI_func(Float64, S1::Number, N::Number, T::Number, R::Number, L::Number, G::Number; const1=const1, const2=const2, const3=const3)
end

indices_funcs["NBUI"] = NBUI_func

function GRNDVI_func(::Type{TFL}, N::Number, G::Number, R::Number) where {TFL <: Number}
    return (N - (G + R))/(N + (G + R))
end

function GRNDVI_func(N::Number, G::Number, R::Number)
    return GRNDVI_func(Float64, N::Number, G::Number, R::Number)
end

indices_funcs["GRNDVI"] = GRNDVI_func

function NBRT3_func(::Type{TFL}, N::Number, T::Number, S2::Number; const1::Number=TFL(10000.0), const2::Number=TFL(10000.0)) where {TFL <: Number}
    return ((N - (T / const1)) - S2) / ((N - (T / const2)) + S2)
end

function NBRT3_func(N::Number, T::Number, S2::Number; const1::Number=TFL(10000.0), const2::Number=TFL(10000.0))
    return NBRT3_func(Float64, N::Number, T::Number, S2::Number; const1=const1, const2=const2)
end

indices_funcs["NBRT3"] = NBRT3_func

function TSAVI_func(::Type{TFL}, sla::Number, N::Number, R::Number, slb::Number) where {TFL <: Number}
    return sla * (N - sla * R - slb) / (sla * N + R - sla * slb)
end

function TSAVI_func(sla::Number, N::Number, R::Number, slb::Number)
    return TSAVI_func(Float64, sla::Number, N::Number, R::Number, slb::Number)
end

indices_funcs["TSAVI"] = TSAVI_func

function NDWI_func(::Type{TFL}, G::Number, N::Number) where {TFL <: Number}
    return (G - N) / (G + N)
end

function NDWI_func(G::Number, N::Number)
    return NDWI_func(Float64, G::Number, N::Number)
end

indices_funcs["NDWI"] = NDWI_func

function NSDSI3_func(::Type{TFL}, S1::Number, S2::Number) where {TFL <: Number}
    return (S1-S2)/(S1+S2)
end

function NSDSI3_func(S1::Number, S2::Number)
    return NSDSI3_func(Float64, S1::Number, S2::Number)
end

indices_funcs["NSDSI3"] = NSDSI3_func

function PISI_func(::Type{TFL}, B::Number, N::Number; const1::Number=TFL(0.8192), const2::Number=TFL(0.5735), const3::Number=TFL(0.0750)) where {TFL <: Number}
    return const1 * B - const2 * N + const3
end

function PISI_func(B::Number, N::Number; const1::Number=TFL(0.8192), const2::Number=TFL(0.5735), const3::Number=TFL(0.0750))
    return PISI_func(Float64, B::Number, N::Number; const1=const1, const2=const2, const3=const3)
end

indices_funcs["PISI"] = PISI_func

function MTCI_func(::Type{TFL}, RE2::Number, RE1::Number, R::Number) where {TFL <: Number}
    return (RE2 - RE1) / (RE1 - R)
end

function MTCI_func(RE2::Number, RE1::Number, R::Number)
    return MTCI_func(Float64, RE2::Number, RE1::Number, R::Number)
end

indices_funcs["MTCI"] = MTCI_func

function MCARI2_func(::Type{TFL}, N::Number, R::Number, G::Number; const1::Number=TFL(1.5), const2::Number=TFL(2.5), const3::Number=TFL(1.3), const4::Number=TFL(2.0), const5::Number=TFL(1), const6::Number=TFL(2), const7::Number=TFL(6.0), const8::Number=TFL(5), const9::Number=TFL(0.5), const10::Number=TFL(0.5), const11::Number=TFL(0.5)) where {TFL <: Number}
    return (const1 * (const2 * (N - R) - const3 * (N - G))) / ((((const4 * N + const5) ^ const6) - (const7 * N - const8 * (R ^ const9)) - const10) ^ const11)
end

function MCARI2_func(N::Number, R::Number, G::Number; const1::Number=TFL(1.5), const2::Number=TFL(2.5), const3::Number=TFL(1.3), const4::Number=TFL(2.0), const5::Number=TFL(1), const6::Number=TFL(2), const7::Number=TFL(6.0), const8::Number=TFL(5), const9::Number=TFL(0.5), const10::Number=TFL(0.5), const11::Number=TFL(0.5))
    return MCARI2_func(Float64, N::Number, R::Number, G::Number; const1=const1, const2=const2, const3=const3, const4=const4, const5=const5, const6=const6, const7=const7, const8=const8, const9=const9, const10=const10, const11=const11)
end

indices_funcs["MCARI2"] = MCARI2_func

function GLI_func(::Type{TFL}, G::Number, R::Number, B::Number; const1::Number=TFL(2.0), const2::Number=TFL(2.0)) where {TFL <: Number}
    return (const1 * G - R - B) / (const2 * G + R + B)
end

function GLI_func(G::Number, R::Number, B::Number; const1::Number=TFL(2.0), const2::Number=TFL(2.0))
    return GLI_func(Float64, G::Number, R::Number, B::Number; const1=const1, const2=const2)
end

indices_funcs["GLI"] = GLI_func

function VI700_func(::Type{TFL}, RE1::Number, R::Number) where {TFL <: Number}
    return (RE1 - R) / (RE1 + R)
end

function VI700_func(RE1::Number, R::Number)
    return VI700_func(Float64, RE1::Number, R::Number)
end

indices_funcs["VI700"] = VI700_func

function NDISIb_func(::Type{TFL}, T::Number, B::Number, N::Number, S1::Number; const1::Number=TFL(3.0), const2::Number=TFL(3.0)) where {TFL <: Number}
    return (T - (B + N + S1) / const1)/(T + (B + N + S1) / const2)
end

function NDISIb_func(T::Number, B::Number, N::Number, S1::Number; const1::Number=TFL(3.0), const2::Number=TFL(3.0))
    return NDISIb_func(Float64, T::Number, B::Number, N::Number, S1::Number; const1=const1, const2=const2)
end

indices_funcs["NDISIb"] = NDISIb_func

function WI2015_func(::Type{TFL}, G::Number, R::Number, N::Number, S1::Number, S2::Number; const1::Number=TFL(1.7204), const2::Number=TFL(171), const3::Number=TFL(3), const4::Number=TFL(70), const5::Number=TFL(45), const6::Number=TFL(71)) where {TFL <: Number}
    return const1 + const2 * G + const3 * R - const4 * N - const5 * S1 - const6 * S2
end

function WI2015_func(G::Number, R::Number, N::Number, S1::Number, S2::Number; const1::Number=TFL(1.7204), const2::Number=TFL(171), const3::Number=TFL(3), const4::Number=TFL(70), const5::Number=TFL(45), const6::Number=TFL(71))
    return WI2015_func(Float64, G::Number, R::Number, N::Number, S1::Number, S2::Number; const1=const1, const2=const2, const3=const3, const4=const4, const5=const5, const6=const6)
end

indices_funcs["WI2015"] = WI2015_func

function BITM_func(::Type{TFL}, B::Number, G::Number, R::Number; const1::Number=TFL(2.0), const2::Number=TFL(2.0), const3::Number=TFL(2.0), const4::Number=TFL(3.0), const5::Number=TFL(0.5)) where {TFL <: Number}
    return (((B^const1)+(G^const2)+(R^const3))/const4)^const5
end

function BITM_func(B::Number, G::Number, R::Number; const1::Number=TFL(2.0), const2::Number=TFL(2.0), const3::Number=TFL(2.0), const4::Number=TFL(3.0), const5::Number=TFL(0.5))
    return BITM_func(Float64, B::Number, G::Number, R::Number; const1=const1, const2=const2, const3=const3, const4=const4, const5=const5)
end

indices_funcs["BITM"] = BITM_func

function S3_func(::Type{TFL}, N::Number, R::Number, S1::Number) where {TFL <: Number}
    return (N * (R - S1)) / ((N + R) * (N + S1))
end

function S3_func(N::Number, R::Number, S1::Number)
    return S3_func(Float64, N::Number, R::Number, S1::Number)
end

indices_funcs["S3"] = S3_func

function TTVI_func(::Type{TFL}, RE3::Number, RE2::Number, N2::Number; const1::Number=TFL(0.5), const2::Number=TFL(865.0), const3::Number=TFL(740.0), const4::Number=TFL(783.0), const5::Number=TFL(740)) where {TFL <: Number}
    return const1 * ((const2 - const3) * (RE3 - RE2) - (N2 - RE2) * (const4 - const5))
end

function TTVI_func(RE3::Number, RE2::Number, N2::Number; const1::Number=TFL(0.5), const2::Number=TFL(865.0), const3::Number=TFL(740.0), const4::Number=TFL(783.0), const5::Number=TFL(740))
    return TTVI_func(Float64, RE3::Number, RE2::Number, N2::Number; const1=const1, const2=const2, const3=const3, const4=const4, const5=const5)
end

indices_funcs["TTVI"] = TTVI_func

function NDCI_func(::Type{TFL}, RE1::Number, R::Number) where {TFL <: Number}
    return (RE1 - R)/(RE1 + R)
end

function NDCI_func(RE1::Number, R::Number)
    return NDCI_func(Float64, RE1::Number, R::Number)
end

indices_funcs["NDCI"] = NDCI_func

function NHFD_func(::Type{TFL}, RE1::Number, A::Number) where {TFL <: Number}
    return (RE1 - A) / (RE1 + A)
end

function NHFD_func(RE1::Number, A::Number)
    return NHFD_func(Float64, RE1::Number, A::Number)
end

indices_funcs["NHFD"] = NHFD_func

function SAVI2_func(::Type{TFL}, N::Number, R::Number, slb::Number, sla::Number) where {TFL <: Number}
    return N / (R + (slb / sla))
end

function SAVI2_func(N::Number, R::Number, slb::Number, sla::Number)
    return SAVI2_func(Float64, N::Number, R::Number, slb::Number, sla::Number)
end

indices_funcs["SAVI2"] = SAVI2_func

function DSWI5_func(::Type{TFL}, N::Number, G::Number, S1::Number, R::Number) where {TFL <: Number}
    return (N + G)/(S1 + R)
end

function DSWI5_func(N::Number, G::Number, S1::Number, R::Number)
    return DSWI5_func(Float64, N::Number, G::Number, S1::Number, R::Number)
end

indices_funcs["DSWI5"] = DSWI5_func

function IAVI_func(::Type{TFL}, N::Number, R::Number, gamma::Number, B::Number) where {TFL <: Number}
    return (N - (R - gamma * (B - R)))/(N + (R - gamma * (B - R)))
end

function IAVI_func(N::Number, R::Number, gamma::Number, B::Number)
    return IAVI_func(Float64, N::Number, R::Number, gamma::Number, B::Number)
end

indices_funcs["IAVI"] = IAVI_func

