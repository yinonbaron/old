# -*- coding: utf-8 -*-
"""
Created on Thu Dec 10 14:36:25 2015

@author: dan
"""
import pandas as pd

proteome_BW = pd.read_csv("modified_data/ecoli_BW_Schmidt_et_al_2015.csv")
proteome_others = pd.read_csv("modified_data/ecoli_others_Schmidt_et_al_2015.csv")

def map_proteomics(df):
    uni_to_b = {row[48:54]:row[0:5].split(';')[0].strip()
                for row in open("source_data/all_ecoli_genes.txt", 'r')}
    
    df.replace(to_replace={'upid':uni_to_b}, inplace=True)
    manual_replacememnts = {
    'D0EX67':'b1107',
    'D4HZR9':'b2755',
    'P00452-2':'b2234',
    'P02919-2':'b0149',
    'Q2A0K9':'b2011',
    'Q5H772':'b1302',
    'Q5H776':'b1298',
    'Q5H777':'b1297',
    'Q6E0U3':'b3183'}
    df.replace(to_replace={'upid':manual_replacememnts}, inplace=True)
    df.set_index('upid', inplace=True)                                
    df.index.name = 'bnumber'
    not_identified = ['B8LFD5','D8FH86','D9IX93','E1MTY0','P0CE60','P23477']
    df.drop(not_identified, axis=0, inplace=True)
    df.sort_index(inplace=True)    
    

map_proteomics(proteome_BW)
map_proteomics(proteome_others)

schmidt = proteome_BW.join(proteome_others, how='outer')
schmidt.to_csv("copies_fL/ecoli_Schmidt_et_al_2015.csv")