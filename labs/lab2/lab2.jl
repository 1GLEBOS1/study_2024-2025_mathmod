import Pkg
Pkg.add("Plots")
Pkg.add("DifferentialEquations")

using Plots
using DifferentialEquations

const a = 6.4
const n = 2.4
const r0 = a / (n + 1)
const r0_2 = a / (n - 1)
const T = (0, 2 * pi)
const T_2 = (-pi, pi)

function F(u, p, t)
    return u / sqrt(n * n - 1)
end

problem = ODEProblem(F, r0, T)
result = solve(problem, abstol=1e-8, reltol=1e-8)

dxR = rand(1:size(result.t)[1])
rAngels = [result.t[dxR] for i in 1:size(result.t)[1]]

plt = plot(proj=:polar, aspect_ratio=:equal, dpi=1000, legend=true, bg=:white)
plot!(plt, xlabel="theta", ylabel="r(t)", title="Случай №1", legend=:outerbottom)
plot!(plt, [rAngels[1], rAngels[2]], [0.0, result.u[end]], label="Путь лодки", color=:blue, lw=1)
scatter!(plt, rAngels, result.u, label="", mc=:blue, ms=0.0005)
plot!(plt, result.t, result.u, xlabel="theta", ylabel="r(t)", label="Путь катера", color=:green, lw=1)
scatter!(plt, result.t, result.u, label="", mc=:green, ms=0.0005)

savefig(plt, "lab2_01.png")

problem = ODEProblem(F, r0_2, T_2)
result = solve(problem, abstol=1e-8, reltol=1e-8)

dxR = rand(1:size(result.t)[1])
rAngels = [result.t[dxR] for i in 1:size(result.t)[1]]

plt1 = plot(proj=:polar, aspect_ratio=:equal, dpi=1000, legend=true, bg=:white)
plot!(plt1, xlabel="theta", ylabel="r(t)", title="Случай №2", legend=:outerbottom)
plot!(plt1, [rAngels[1], rAngels[2]], [0.0, result.u[end]], label="Путь лодки", color=:blue, lw=1)
scatter!(plt1, rAngels, result.u, label="", mc=:blue, ms=0.0005)
plot!(plt1, result.t, result.u, xlabel="theta", ylabel="r(t)", label="Путь катера", color=:green, lw=1)
scatter!(plt1, result.t, result.u, label="", mc=:green, ms=0.0005)

savefig(plt1, "lab2_02.png")
