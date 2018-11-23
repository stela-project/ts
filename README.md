## STELA-project: Technology stack supporting a learning analytics dashboard

A dashboard is a visual display of the most relevant information, which is consolidated and arranged on a single screen to be monitored at a glance and needed to achieve one or more objectives [1]. A dashboard often present information to resources used, time spent, social interactions, artifacts produced, and exercise and test results [2]. Thus, the students are able to monitor their learning efforts for reaching their intended learning outcomes more easily [3].

For the design and development of the learning analytics dashboard, we determined the following three objectives:
<ul>
  <li>cover the demands of the different stakeholders,</li>
  <li>maximize the mainstreaming potential and transferability to other contexts, and</li>
  <li>make it available for everyone by developing in the path of Open Source.</li>
</ul>

The research concentrates on developing an appropriate concept to fulfill these objectives and finding a suitable technology stack. Therefore, we determine the capabilities and functionalities of the dashboard for the different stakeholders. This is of significant importance as it identifies which data can be collected, which feedback can be given, and which functionalities are provided.

The main demands of the stakeholders are the support of different data-sources as well as different types of data-sources. Therefore, we searched for appropriate technologies which support various kinds of sources. During this search, we focused on technologies which are available under an Open Source licenses to cover our third objective.

Further, we wanted to easily combine different technologies, so we decided to go with a modular architecture. This ensures that the stakeholders can choose between different software modules (e.g. they can choose to use proprietary software) for easy adjustment to their needs. We decided to use a design with three layers:
<ul>
  <li>the data collection,</li>
  <li>the search and information processing,</li>
  <li>the data presentation.</li>
</ul>

Additionally, this approach helped us with our second objective, the transferability to other contexts and the maximization of the mainstreaming potential.

This images shows the final design of our technology stack:
<img src="https://raw.githubusercontent.com/stela-project/ts/master/ts.jpg" alt="Image of techhnology stack" width="600" height="auto">

<b>Acknowledgments.</b> This research project is co-funded by the European Commission Erasmus+ program, in the context of the project 562167-EPP-1-2015-1-BE-EPPKA3-PI-FORWARD. Please visit our website http://stela-project.eu.
