from allensdk.api.queries.rma_api import RmaApi
import pandas as pd
import requests, zipfile, StringIO
api = RmaApi()

# specify the directories
abs_dir = os.path.dirname(__file__)
rel_dir = os.path.join(abs_dir, '..','Data','API','Unionizes')

ages = ['E11.5','E13.5','E15.5','E18.5','P4','P14','P28']

age_str = "'" + "','".join(age_names) + "'"

criteria=['[failed$eqfalse]'',
           'products[abbreviation$eqDevMouse]'',
           'specimen(donor(age[name$in%s])),' %age_str,
           'plane_of_section[name$eqsagittal]',
           ],
experiment=api.model_query('SectionDataSet',
                            criteria="".join(criteria),
                            include='probes(gene),specimen(donor(age))',
                            start_row=0,
                            num_rows='all')
# extract the info
expID_list=[]
age_list=[]
geneID_list=[]
geneAcronym_list=[]

for counter, value in enumerate(experiment):
    #only keep those experiments with entrez ID available
    if experiment[counter]['probes']:
        if not (experiment[counter]['probes'][0]['gene']['entrez_id']==None):
            expID_list.append(experiment[counter]['id'])
            age_list.append(experiment[counter]['specimen']['donor']['age']['name'])
            geneID_list.append(experiment[counter]['probes'][0]['gene']['entrez_id'])
            geneAcronym_list.append(experiment[counter]['probes'][0]['gene']['acronym'])

# create the URL
API_PATH='http://api.brain-map.org/grid_data/download/'
URL_list=[]
dataType=['energy','intensity']
dataType_str = ','.join(dataType)

for j in expID_list: # for each experiment
    URL=(('%s' %(API_PATH)) +\
        '%d' % (j) +\
        '?include=' +\
        '%s' %(dataType_str))
    URL_list.append(URL)

for j in range(len(URL_list)): #len(URL_list)
    r = requests.get(URL_list[j], stream=True)
    z = zipfile.ZipFile(StringIO.StringIO(r.content))
    dirName=os.path.join([directory,age_list[j],'\\\\',age_list[j],'_',str(geneID_list[j])])
