using Plots
using Distributions
# using Turing
using StatsPlots
using CSV, DataFrames
using Dates,Measures


# Import necessary libraries
using DelimitedFiles

# Function to extract values based on a pattern
function extract_values(file_content, pattern)
    # Initialize an empty array to store extracted values
    extracted_values = []
    # Loop through each line in the file content
    for line in file_content
        # If the line matches the pattern, extract the numeric value
        if occursin(pattern, line)
            # Extract the value after the colon and convert it to Float64
            value = parse(Float64, split(line, ": ")[end])
            push!(extracted_values, value)
        end
    end
    return extracted_values
end


all_client_rmspe_trunc=[]
all_server_rmspe_trunc=[]
all_client_avg_width_trunc=[]
all_server_avg_width_trunc=[]
for i=1:10
    # Read the .txt file content
    file_content = readlines("/exp_with_truncation/run$(i)/r$(i).txt")  # Replace "data.txt" with your actual file path

    client_rmspe_trunc = extract_values(file_content, "Student1 (client) - RMSPE(true,pred Student1)")
    server_rmspe_trunc = extract_values(file_content, "Ensemble (Server) - RMSPE(true,mean Ensemble)")
    client_avg_width_trunc = extract_values(file_content, "Student2 (client) - The average width for")
    server_avg_width_trunc = extract_values(file_content, "Ensemble (Server) - The average width for")

    append!(all_client_rmspe_trunc,[client_rmspe_trunc])
    append!(all_server_rmspe_trunc,[server_rmspe_trunc])
    append!(all_client_avg_width_trunc,[client_avg_width_trunc])
    append!(all_server_avg_width_trunc,[server_avg_width_trunc])
end

mean_all_client_rmspe_trunc = mean(hcat(all_client_rmspe_trunc...)', dims=1)
std_all_client_rmspe_trunc = std(hcat(all_client_rmspe_trunc...)', dims=1)
mean_all_client_avg_width_trunc = mean(hcat(all_client_avg_width_trunc...)', dims=1)
std_all_server_avg_width_trunc = std(hcat(all_server_avg_width_trunc...)', dims=1)


all_client_rmspe_notrunc=[]
all_server_rmspe_notrunc=[]
all_client_avg_width_notrunc=[]
all_server_avg_width_notrunc=[]
for i=1:10
    # Read the .txt file content
    file_content = readlines("/exp_without_truncation/run$(i)/r$(i).txt")  # Replace "data.txt" with your actual file path

    client_rmspe_notrunc = extract_values(file_content, "Student1 (client) - RMSPE(true,pred Student1)")
    server_rmspe_notrunc = extract_values(file_content, "Ensemble (Server) - RMSPE(true,mean Ensemble)")
    client_avg_width_notrunc = extract_values(file_content, "Student2 (client) - The average width for")
    server_avg_width_notrunc = extract_values(file_content, "Ensemble (Server) - The average width for")

    append!(all_client_rmspe_notrunc,[client_rmspe_notrunc])
    append!(all_server_rmspe_notrunc,[server_rmspe_notrunc])
    append!(all_client_avg_width_notrunc,[client_avg_width_notrunc])
    append!(all_server_avg_width_notrunc,[server_avg_width_notrunc])
end

mean_all_client_rmspe_notrunc = mean(hcat(all_client_rmspe_notrunc...)', dims=1)
std_all_client_rmspe_notrunc = std(hcat(all_client_rmspe_notrunc...)', dims=1)
mean_all_client_avg_width_notrunc = mean(hcat(all_client_avg_width_notrunc...)', dims=1)
std_all_server_avg_width_notrunc = std(hcat(all_server_avg_width_notrunc...)', dims=1)



all_fedAvg_noniid=[]
for i=1:10
    file_content = readlines("/baseline_fedAavg/$(i)-non-iid/res.txt")  # Replace "data.txt" with your actual file path
    res = extract_values(file_content, "FedAVG (server) round")
    append!(all_fedAvg_noniid,[res])
end
mean_all_fedAvg_noniid = mean(hcat(all_fedAvg_noniid...)', dims=1)
std_all_fedAvg_noniid = std(hcat(all_fedAvg_noniid...)', dims=1)


all_fedAvg_iid=[]
for i=1:10
    file_content = readlines("/baseline_fedAavg/$(i)-iid/res.txt")  # Replace "data.txt" with your actual file path
    res = extract_values(file_content, "FedAVG (server) round")
    append!(all_fedAvg_iid,[res])
end
mean_all_fedAvg_iid = mean(hcat(all_fedAvg_iid...)', dims=1)
std_all_fedAvg_iid = std(hcat(all_fedAvg_iid...)', dims=1)




lws=7
gr( xtickfontsize=10, ytickfontsize=10, xguidefontsize=10, yguidefontsize=10, legendfontsize=10);
p1=
plot(Array(0:1:100), mean_all_client_rmspe_trunc',c=:lightblue, title="2S with truncation", label="W_pred (Client)",w=lws,xlabel="round", ylabel ="RMSPE")
# plot!(Array(0:1:length(server_rmspe_trunc)-1), server_rmspe_trunc,linestyle=:dot, c=:red2,label="Ensemble (Server)",w=lws,alpha = 0.5)
scatter!( [100],[2.212665023309583],label="GP optimized via LBFGS", markershape=:star5, markercolor=:blue, markersize=12,alpha = 0.5)
# scatter!( [100],[mean_all_fedAvg_iid[end]],label="mean_all_fedAvg_iid", markershape=:star5, markercolor=:red, markersize=12,alpha = 0.5)
# scatter!( [100],[mean_all_fedAvg_noniid[end]],label="mean_all_fedAvg_iid", markershape=:star5, markercolor=:orange, markersize=12,alpha = 0.5)
vline!([2], label="Truncation begin (round 10)", linestyle=:dot, linewidth=4, color=:purple,alpha = 0.5)

p2=
plot(Array(0:1:length(mean_all_client_avg_width_trunc')-1) , mean_all_client_avg_width_trunc', c=:lightblue,label="W_uq (Client)",w=lws,xlabel="round", ylabel ="Average width of 95% CIs")
# plot!(Array(0:1:length(server_avg_width_trunc)-1), server_avg_width_trunc, linestyle=:dot, c=:red2,label="Ensemble (Server)",w=lws,alpha = 0.5)
vline!([2], label="Truncation begin (round 10)", linestyle=:dot, linewidth=4, color=:purple,alpha = 0.5)
scatter!( [100],[0.2058380538200764],label="GP optimized via LBFGS", markershape=:star5, markercolor=:blue, markersize=12,alpha = 0.5)
yaxis!([0.0,2])
# result_gp_opt2 - The average width for 95%  credible intervals: 0.2058380538200764 , RMSPE(true,result_gp_opt2): 2.212665023309583

ppp1=plot(p1,p2,layout=(2,1),size=(500,700),grid=false,left_margin=4mm,bottom_margin=0mm)
savefig("/fig_metrics1.png")
display(ppp1)

lws=7
gr( xtickfontsize=10, ytickfontsize=10, xguidefontsize=10, yguidefontsize=10, legendfontsize=10);
p1=
plot(Array(0:1:100), mean_all_client_rmspe_notrunc',c=:lightblue, title="2S without truncation", label="W_pred (Client)",w=lws,xlabel="round", ylabel ="RMSPE")
# plot!(Array(0:1:length(server_rmspe_trunc)-1), server_rmspe_trunc,linestyle=:dot, c=:red2,label="Ensemble (Server)",w=lws,alpha = 0.5)
scatter!( [100],[2.212665023309583],label="GP optimized via LBFGS", markershape=:star5, markercolor=:blue, markersize=12,alpha = 0.5)
# vline!([10], label="Truncation begin (round 10)", linestyle=:dot, linewidth=4, color=:purple,alpha = 0.5)
# scatter!( [100],[mean_all_fedAvg_iid[end]],label="mean_all_fedAvg_iid", markershape=:star5, markercolor=:red, markersize=12,alpha = 0.5)
# scatter!( [100],[mean_all_fedAvg_noniid[end]],label="mean_all_fedAvg_iid", markershape=:star5, markercolor=:orange, markersize=12,alpha = 0.5)

p2=
plot(Array(0:1:length(mean_all_client_avg_width_notrunc')-1) , legend=:bottomleft, mean_all_client_avg_width_notrunc', c=:lightblue,label="W_uq (Client)",w=lws,xlabel="round", ylabel ="Average width of 95% CIs")
# plot!(Array(0:1:length(server_avg_width_trunc)-1), server_avg_width_trunc, linestyle=:dot, c=:red2,label="Ensemble (Server)",w=lws,alpha = 0.5)
# vline!([10], label="Truncation begin (round 10)", linestyle=:dot, linewidth=4, color=:purple,alpha = 0.5)
scatter!( [100],[0.2058380538200764],label="GP optimized via LBFGS", markershape=:star5, markercolor=:blue, markersize=12,alpha = 0.5)
yaxis!([0.0,2.0])
# result_gp_opt2 - The average width for 95%  credible intervals: 0.2058380538200764 , RMSPE(true,result_gp_opt2): 2.212665023309583


ppp2=plot(p1,p2,layout=(2,1),size=(500,700),grid=false,left_margin=4mm,bottom_margin=0mm)
ppp3=plot(ppp1,ppp2,layout=(1,2),size=(900,700),grid=false,left_margin=4mm,bottom_margin=0mm)


savefig("/fig_metrics.png")
display(ppp3)










# table



all_fedAvg_noniid=[]
for i=1:10
    file_content = readlines("/baseline_fedAavg/$(i)-non-iid/res.txt")  # Replace "data.txt" with your actual file path
    res = extract_values(file_content, "FedAVG (server) round")
    append!(all_fedAvg_noniid,[res])
end
mean_all_fedAvg_noniid = mean(hcat(all_fedAvg_noniid...)', dims=1)
std_all_fedAvg_noniid = std(hcat(all_fedAvg_noniid...)', dims=1)


all_fedAvg_iid=[]
for i=1:10
    file_content = readlines("/baseline_fedAavg/$(i)-iid/res.txt")  # Replace "data.txt" with your actual file path
    res = extract_values(file_content, "FedAVG (server) round")
    append!(all_fedAvg_iid,[res])
end
mean_all_fedAvg_iid = mean(hcat(all_fedAvg_iid...)', dims=1)
std_all_fedAvg_iid = std(hcat(all_fedAvg_iid...)', dims=1)




for idn in [1,2, 26,51,76, 101]
println(idn-1," & ", round(mean_all_client_rmspe_trunc[idn], digits = 3)," _std ",  round(std_all_client_rmspe_trunc[idn], digits = 3), " & ",
        # round(mean_all_client_rmspe_notrunc[idn], digits = 3)," _std ", round(std_all_client_rmspe_notrunc[idn], digits = 3)," & ",
        round(mean_all_fedAvg_iid[idn], digits = 3) ," _std ",  round(std_all_fedAvg_iid[idn], digits = 3) ," & ",
        round(mean_all_fedAvg_noniid[idn], digits = 3), " _std ", round(std_all_fedAvg_noniid[idn], digits = 3) )
end


























#
# ppp = plot(Array(0:1:100), (mean_all_client_rmspe_trunc.-std_all_client_rmspe_trunc)',
# (fillrange=mean_all_client_rmspe_trunc.+std_all_client_rmspe_trunc)',
# fillalpha=1.9, linecolor=:transparent, label="95% CI GP", w=3, colour=:gainsboro)
#
#
# plot(Array(0:1:100), (mean_all_client_rmspe_trunc.-std_all_client_rmspe_trunc)', c=:gainsboro, label=false, w=4, alpha=1.5)
# plot!(Array(0:1:100), (mean_all_client_rmspe_trunc.+std_all_client_rmspe_trunc)', c=:gainsboro, label=false, w=4, alpha=1.5)
# # plot!(xTest, cos.(xTest),c=:red3, label="true",w=4,alpha = 1)
# plot!(Array(0:1:100), mean_all_client_rmspe_trunc', c=:slategray,label="mean 2S",w=4,alpha = 1)
# # plot!(x, y, seriestype=:scatter, c=:lightsteelblue3, xlabel="x", ylabel="y", grid=false, label="train Data",title="GP optimized via LBFGS")
# # yaxis!(ppp, [-1.5,1.5], subplot=1)
#
#
# plot!(Array(0:1:100), (mean_all_fedAvg_iid.-std_all_fedAvg_iid)', c=:lightblue, label=false, w=4, alpha=1.5)
# plot!(Array(0:1:100), (mean_all_fedAvg_iid.+std_all_fedAvg_iid)', c=:lightblue, label=false, w=4, alpha=1.5)
# # plot!(xTest, cos.(xTest),c=:red3, label="true",w=4,alpha = 1)
# plot!(Array(0:1:100), mean_all_fedAvg_iid', c=:blue,label="mean fedAvg",w=4,alpha = 1)
# # plot!(x, y, seriestype=:scatter, c=:lightsteelblue3, xlabel="x", ylabel="y", grid=false, label="train Data",title="GP optimized via LBFGS")
# # yaxis!(ppp, [-1.5,1.5], subplot=1)
#
#
#
#
#
#
#
#
#
#
#
# lws=7
# gr( xtickfontsize=10, ytickfontsize=10, xguidefontsize=10, yguidefontsize=10, legendfontsize=10);
# p1=
# plot(Array(0:1:100), client_rmspe_trunc,c=:lightblue, title="2S with truncation", label="W_pred (Client)",w=lws,xlabel="round", ylabel ="RMSPE")
# # plot!(Array(0:1:length(server_rmspe_trunc)-1), server_rmspe_trunc,linestyle=:dot, c=:red2,label="Ensemble (Server)",w=lws,alpha = 0.5)
# scatter!( [100],[2.212665023309583],label="GP optimized via LBFGS", markershape=:star5, markercolor=:blue, markersize=12,alpha = 0.5)
# vline!([10], label="Truncation begin (round 10)", linestyle=:dot, linewidth=4, color=:purple,alpha = 0.5)
#
# p2=
# plot(Array(0:1:length(client_avg_width_trunc)-1) , client_avg_width_trunc, c=:lightblue,label="W_uq (Client)",w=lws,xlabel="round", ylabel ="Average width of 95% CIs")
# # plot!(Array(0:1:length(server_avg_width_trunc)-1), server_avg_width_trunc, linestyle=:dot, c=:red2,label="Ensemble (Server)",w=lws,alpha = 0.5)
# vline!([10], label="Truncation begin (round 10)", linestyle=:dot, linewidth=4, color=:purple,alpha = 0.5)
# scatter!( [100],[0.2058380538200764],label="GP optimized via LBFGS", markershape=:star5, markercolor=:blue, markersize=12,alpha = 0.5)
# yaxis!([0.0,1.2])
# # result_gp_opt2 - The average width for 95%  credible intervals: 0.2058380538200764 , RMSPE(true,result_gp_opt2): 2.212665023309583
#
#
# ppp1=plot(p1,p2,layout=(2,1),size=(500,700),grid=false,left_margin=4mm,bottom_margin=0mm)
# savefig("/fig_metrics1.png")
# display(ppp1)
#
# # Read the .txt file content
# file_content = readlines("/exp_without_truncation/res.txt")  # Replace "data.txt" with your actual file path
#
#
# #experiment without truncation
# # Extract values related to RMSPE and average width for 95% credible intervals
# client_rmspe = extract_values(file_content, "Student1 (client) - RMSPE(true,pred Student1)")
# server_rmspe = extract_values(file_content, "Ensemble (Server) - RMSPE(true,mean Ensemble)")
# client_avg_width = extract_values(file_content, "Student2 (client) - The average width for")
# server_avg_width = extract_values(file_content, "Ensemble (Server) - The average width for")
#
#
#
#
#
# lws=7
# gr( xtickfontsize=10, ytickfontsize=10, xguidefontsize=10, yguidefontsize=10, legendfontsize=10);
# p1=
# plot(Array(0:1:100), client_rmspe,c=:lightblue, title="2S without truncation", label="W_pred (Client)",w=lws,xlabel="round", ylabel ="RMSPE")
# # plot!(Array(0:1:length(server_rmspe_trunc)-1), server_rmspe_trunc,linestyle=:dot, c=:red2,label="Ensemble (Server)",w=lws,alpha = 0.5)
# scatter!( [100],[2.212665023309583],label="GP optimized via LBFGS", markershape=:star5, markercolor=:blue, markersize=12,alpha = 0.5)
# # vline!([10], label="Truncation begin (round 10)", linestyle=:dot, linewidth=4, color=:purple,alpha = 0.5)
#
# p2=
# plot(Array(0:1:length(client_avg_width)-1) , legend=:bottomleft, client_avg_width, c=:lightblue,label="W_uq (Client)",w=lws,xlabel="round", ylabel ="Average width of 95% CIs")
# # plot!(Array(0:1:length(server_avg_width_trunc)-1), server_avg_width_trunc, linestyle=:dot, c=:red2,label="Ensemble (Server)",w=lws,alpha = 0.5)
# # vline!([10], label="Truncation begin (round 10)", linestyle=:dot, linewidth=4, color=:purple,alpha = 0.5)
# scatter!( [100],[0.2058380538200764],label="GP optimized via LBFGS", markershape=:star5, markercolor=:blue, markersize=12,alpha = 0.5)
# yaxis!([0.0,1.2])
# # result_gp_opt2 - The average width for 95%  credible intervals: 0.2058380538200764 , RMSPE(true,result_gp_opt2): 2.212665023309583
#
#
# ppp2=plot(p1,p2,layout=(2,1),size=(500,700),grid=false,left_margin=4mm,bottom_margin=0mm)
#
#
# ppp3=plot(ppp1,ppp2,layout=(1,2),size=(900,700),grid=false,left_margin=4mm,bottom_margin=0mm)
#
#
# savefig("/fig_metrics.png")
# display(ppp3)
