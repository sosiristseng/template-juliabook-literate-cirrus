using Distributed
using PrettyTables

@everywhere begin
    using Literate
end

folder = joinpath(@__DIR__, "docs")
nbs = [nb for nb in readdir(folder) if endswith(nb, ".jl")]
config = Dict("mdstrings" => true, "execute" => true)

ts = pmap(nbs; on_error=ex->NaN) do nb
    @elapsed Literate.notebook(joinpath(folder, nb), folder; config)
end

pretty_table([nbs ts], header=["Notebook", "Elapsed (s)"])

for (nb, t) in zip(nbs, ts)
    if isnan(t)
        println("Debugging notebook: ", nb)
        withenv("JULIA_DEBUG" => "Literate") do
            Literate.notebook(joinpath(folder, nb), folder; config)
        end
    end
end

any(isnan, ts) && error("Error(s) occured!")