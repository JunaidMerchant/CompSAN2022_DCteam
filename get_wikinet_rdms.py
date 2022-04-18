import pandas as pd, numpy as np, networkx as nx
import matplotlib.pyplot as plt, seaborn as sns

# create RDMs
edgelist_df = pd.read_excel('model_rdm_data/wiki_network.xlsx', engine='openpyxl', sheet_name='edgelist')
social_network = nx.from_pandas_edgelist(edgelist_df, source='actor1', target='actor2', edge_attr='weight')
df_adj = nx.to_pandas_adjacency(social_network)
df_adj.to_csv('model_rdm_data/socialNetwork_5x5.csv')

# total number events = 297
labels = ['GaiusCharles']*34 + ['KyleChandler']*142 + ['ScottPorter']*48 + ['TaylorKitsch']*34 + ['ZachGilford']*39

rdm = np.ones((len(labels), len(labels)))
for index1, label1 in enumerate(labels):
    for index2, label2 in enumerate(labels):
        if label1==label2:
            rdm[index1,index2] = 0
        else:
            rdm[index1,index2] = 1 - df_adj.loc[label1][label2]

np.savetxt("model_rdm_data/socialNetwork_297x297.csv", rdm, delimiter=",")

# create plots
edgelist_df = pd.read_excel('model_rdm_data/wiki_network.xlsx', engine='openpyxl', sheet_name='edgelist_chars')
social_network = nx.from_pandas_edgelist(edgelist_df, source='actor1', target='actor2', edge_attr='weight')
adj_mat = nx.adjacency_matrix(social_network, nodelist=social_network.nodes())

# plot matrix
mask = np.triu(np.ones_like(adj_mat.todense(), dtype=bool))
sns.heatmap(adj_mat.todense(), cmap='Reds', xticklabels=social_network.nodes(), yticklabels=social_network.nodes(), vmax=1, mask=mask)
plt.savefig("FNL_NetworkMatrix.png", dpi=450, bbox_inches='tight', format="PNG")

# plot weighted graph
weights = [10*(social_network[u][v]['weight']) for u,v in social_network.edges()]
plt.xlim(-1.25,1.35)
pos = nx.draw_spring(social_network, width=weights, color='green', 
            with_labels=True, bbox=dict(facecolor='white', alpha=0.7))

plt.tight_layout()
plt.savefig("FNL_Network.png", scale=1, dpi=450, format="PNG")