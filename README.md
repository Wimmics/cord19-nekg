# Covid-on-the-Web Dataset

*Covid-on-the-Web Dataset* is an RDF dataset that provides two main knowledge graphs produced by analyzing the scholarly articles of the [COVID-19 Open Research Dataset (CORD-19)](https://www.semanticscholar.org/cord19) [1], a resource of articles about COVID-19 and the coronavirus family of viruses:
- the *CORD-19 Named Entities Knowledge Graph* describes named entities identified and disambiguated by NCBO BioPortal annotator, Entity-fishing and DBpedia Spotlight. 
- the *CORD-19 Argumentative Knowledge Graph* describes argumentative components and PICO elements (Patient/Population/Problem, Intervention, Comparison, Outcome) extracted from the articles by the Argumentative Clinical Trial Analysis platform (ACTA).

A description of the dataset, in the Turtle format, as well as examples are provided in the [dataset](dataset) directory.

Covid-on-the-Web Dataset is an initiative of the [Wimmics team](https://team.inria.fr/wimmics/), [I3S laboratory](http://www.i3s.unice.fr/), University Côte d'Azur, Inria, CNRS.

Covid-on-the-Web Dataset **v1.2** is based on [CORD-19 v47](https://www.kaggle.com/dataset/08dd9ead3afd4f61ef246bfd6aee098765a19d9f6dbf514f0142965748be859b/version/47). 
 

## Documentation

- [RDF data modeling](doc/01-data-modeling.md)
- [Generation pipeline](src/README.md)


## CORD-19 Named Entities Knowledge Graph (CORD19-NEKG)

To identify and disambiguate named entities, we used [DBpedia Spotlight](https://www.dbpedia-spotlight.org/) (links to DBpedia), [Entity-fishing](https://github.com/kermitt2/entity-fishing) (links to Wikidata), and [NCBO BioPortal annotator](http://bioportal.bioontology.org/annotatorplus) (links to ontologies in Bioportal).

Named entities were identified primarily in the articles' titles and abstracts. Entity-fishing was also used to process the articles' bodies.

The table below shows the total number of named entities extracted by each tool, as well as the corresponding number of unique URIs.


|                    | DBpedia    | Wikidata      | Bioportal   | Total |
| :-------------     | --: | --: | --: | --: |
| No. named entities |  4,084,979 |    66,098,777 |  42,972,551 |   113,156,307 |
| No. unique URIs    |     63,750 |       252,150 |     429,755 |       745,655 |


## CORD-19 Argumentative Knowledge Graph (CORD19-AKG)

To extract argumentative components (claims and evidences) and PICO elements, we used the [Argumentative Clinical Trial Analysis](http://ns.inria.fr/acta/) platform (ACTA) [2].

Argumentative components and PICO elements were extracted from the articles' abstracts.

| | ACTA |
| ------------- | ---------: |
| No. argumentative components | 119,053 |
| No. PICO elements linked to UMLS concepts | 515,590 |
| No. unique UMLS concepts | 31,841 |



## URIs naming scheme

Covid-on-the-Web namespace is `http://ns.inria.fr/covid19/`. All URIs are dereferenceable.

The dataset itslef is identified by URI [`http://ns.inria.fr/covid19/covidontheweb-1-2`](http://ns.inria.fr/covid19/covidontheweb-1-2). It comes with DCAT and VOID descriptions.
All articles, annotations and arguments are linked back to the dataset with property `rdfs:isDefinedBy`.

Article URIs are formatted as `http://ns.inria.fr/covid19/paper_id` where paper_id may be either the article SHA hash or its PCM identifier.
Parts of an article (title, abstract and body) are also identified by URIs so that annotations of named entities can link back to the part they belong to. These URIs are formatted as 
- `http://ns.inria.fr/covid19/paper_id#title`
- `http://ns.inria.fr/covid19/paper_id#abstract`
- `http://ns.inria.fr/covid19/paper_id#body_text`.


## Downloading and SPARQL Querying

The dataset is downloadable as a set of RDF dumps (in Turtle syntax) from Zenodo: [![DOI](https://zenodo.org/badge/DOI/10.5281/zenodo.4247134.svg)](https://doi.org/10.5281/zenodo.4247134)

It can also be queried through our Virtuoso OS SPARQL endpoint https://covidontheweb.inria.fr/sparql.

You may use the [Faceted Browser](http://covidontheweb.inria.fr/fct/) to look up text or URIs.
As an example, you can look up article [http://ns.inria.fr/covid19/d53508d43264f59007fd5e4aa8b4af026edf0bfe](http://ns.inria.fr/covid19/d53508d43264f59007fd5e4aa8b4af026edf0bfe).
Further details about how named entities are represented in RDF are given in the [Data Modeling](doc/01-data-modeling.md) section.

The following **named graphs** can be queried from our SPARQL endpoint:

| Named graph    | Description | No. RDF triples |
| -------------  | ---- | ----: |
| http://ns.inria.fr/covid19/graph/metadata | dataset description + definition of a few properties | 170 |
| http://ns.inria.fr/covid19/graph/articles | articles metadata (title, authors, DOIs, journal etc.) | 3,722,381 |
| http://ns.inria.fr/covid19/graph/entityfishing | named entities identified by Entity-fishing in articles titles/abstracts | 35,049,832 |
| http://ns.inria.fr/covid19/graph/entityfishing/body | named entities identified by Entity-fishing in articles bodies | 1,156,611,321 |
| http://ns.inria.fr/covid19/graph/bioportal-annotator | named entities identified by Bioportal Annotator in articles titles/abstracts | 104,430,547 |
| http://ns.inria.fr/covid19/graph/dbpedia-spotlight | named entities identified by DBpedia Spotlight in articles titles/abstracts | 65,359,664 |
| http://ns.inria.fr/covid19/graph/acta | argumentative components and PICO elements extracted by ACTA from articles titles/abstracts | 7,469,234 |
| Total | | 1,361,451,364 | 

The example query below retrieves two articles that have been annotated with at least one common Wikidata entity.
```sparql
select ?uri ?title1 ?title2
where {
  graph <http://ns.inria.fr/covid19/graph/articles> {
    ?paper1 a fabio:ResearchPaper; dct:title ?title1.
    ?paper2 a fabio:ResearchPaper; dct:title ?title2.
    filter (?paper1 != ?paper2)
  }
  
  graph <http://ns.inria.fr/covid19/graph/entityfishing> {
    ?a1 a oa:Annotation;
        schema:about ?paper1;
        oa:hasBody ?uri.
    ?a2 a oa:Annotation;
        schema:about ?paper2;
        oa:hasBody ?uri.
  }
} limit 10
```


## License

See the [LICENSE file](LICENSE).

## Cite this work

When including Covid-on-the-Web data in a publication or redistribution, please cite this paper:

Franck Michel, Fabien Gandon, Valentin Ah-Kane, Anna Bobasheva, Elena Cabrio, Olivier Corby, Raphaël Gazzotti, Alain Giboin, Santiago Marro, Tobias Mayer, Mathieu Simon, Serena Villata, Marco Winckler. Covid-on-the-Web: Knowledge Graph and Services to Advance COVID-19 Research. International Semantic Web Conference (ISWC), Nov 2020, Athens, Greece. [PDF](https://hal.archives-ouvertes.fr/hal-02939363/file/article-cam-ready.pdf)


## References

[1] Wang, L.L., Lo, K., Chandrasekhar, Y., Reas, R., Yang, J., Eide, D., Funk, K., Kinney, R.M., Liu, Z., Merrill, W., Mooney, P., Murdick, D.A., Rishi, D., Sheehan, J., Shen, Z., Stilson, B., Wade, A.D., Wang, K., Wilhelm, C., Xie, B., Raymond, D.M., Weld, D.S., Etzioni, O., & Kohlmeier, S. (2020). CORD-19: The Covid-19 Open Research Dataset. ArXiv, abs/2004.10706.

[2] T. Mayer, E. Cabrio, and S. Villata. ACTA a tool for argumentative clinical trialanalysis. In Proceedings of the 28th International Joint Conference on  ArtificialIntelligence (IJCAI), pages 6551–6553, 2019.

