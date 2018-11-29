## STELA-project: Technology stack supporting a learning analytics dashboard

<img src="https://raw.githubusercontent.com/stela-project/ts/master/images/logo.png" alt="Logo STELA-Project" width="200" height="auto"> 

### Quick start guide
1) Open command line (recommended for Windows: git-bash) 
2) Go to subfolder "vagrant" 
3) Install a plugin which will install the 'VirtualBox Guest Additional Tools': "vagrant plugin install vagrant-vbguest"
4) Start the virtual machine: "vagrant up"
5) On the host open a browser and go to http://localhost:8080 
6) Shutdown the virtual machine: "vagrant halt"

### Setup information

The basic setup takes place in the _custom.sh_ script,  but the important setup concerning our technology stack happens in the _custom.sh_. Both are located at _vagrant/config/shell_.

#### Data collection

```sh
# logstash
echo "install logstash .."

echo "
[logstash-6.x]
name=Elastic repository for 6.x packages
baseurl=https://artifacts.elastic.co/packages/6.x/yum
gpgcheck=1
gpgkey=https://artifacts.elastic.co/GPG-KEY-elasticsearch
enabled=1
autorefresh=1
type=rpm-md
 " > /etc/yum.repos.d/logstash.repo

yum install -y logstash

systemctl enable logstash.service
systemctl start logstash.service
```

#### Search & information processing

```sh
## import elastic package key see https://www.elastic.co/guide/en/elasticsearch/reference/current/setup-repositories.html
echo "install elastic package .."
rpm --import https://packages.elastic.co/GPG-KEY-elasticsearch

## elasticsearch
echo "install elastic search .."

echo "
[elasticsearch-6.x]
name=Elasticsearch repository for 6.x packages
baseurl=https://artifacts.elastic.co/packages/6.x/yum
gpgcheck=1
gpgkey=https://artifacts.elastic.co/GPG-KEY-elasticsearch
enabled=1
autorefresh=1
type=rpm-md
" > /etc/yum.repos.d/elasticsearch.repo
yum install -y elasticsearch

systemctl enable elasticsearch.service
systemctl start elasticsearch.service

sleep 15

# elasticsearch config
cp /vagrant_config/files/elkstack/elasticsearch.yml /etc/elasticsearch/elasticsearch.yml
sudo /etc/init.d/elasticsearch restart

[...]

## postgres
echo "create database.."
su - postgres -c 'createuser stela'
su - postgres -c 'createdb -O stela stela'
```

Additionally, the PHP-framework CodeIgnitor (https://codeigniter.com/) was used to combine the strengths of elasticsearch and postgres. It enables the postprocessing of the data and prepares it for presentation and visualization. It is located in the _src_ folder, but the model, view and controller may be found at _src/application_.

#### Data presentation

For the data presentation the library Charts.js was used - Link: https://www.chartjs.org/. It is inserted in the header of the CodeIgnitor-Framework and located at _src/assets/js/Chart.bundle.min.js_.

<b>Example visualization</b>
```html
<canvas id="bar-chart-total-time-spent-on-system" style="display: block; height: 262px; width: 525px;" width="656" height="327" class="chartjs-render-monitor"></canvas>
<script>
    // Bar chart
    $bar_chart = document.getElementById("bar-chart-total-time-spent-on-system");
    new Chart($bar_chart, {
        type: 'bar',
        data: {
            labels: ["< 1 min",
                "1 min - 10 h ","10 h  - 20 h ","20 h  - 1 d 6 h ", "> 1 d 6 h "],
            datasets: [
                {
                    label: "User",
                    backgroundColor: ["#3e95cd","#8e5ea2","#3cba9f","#e8c3b9","#c45850"],
                    data: [259,389,188,85,125]                            }
            ]
        },
        options: {
            legend: { display: false },
            title: {
                text: "Total time spent on the system per user",
                display: true
            },
            responsive: true
        }
    });
</script>
```
<img src="https://raw.githubusercontent.com/stela-project/ts/master/images/time_spent_on_system_per_user.png" alt="Charts.js example" width="600" height="auto"> 

### Description

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
<img src="https://raw.githubusercontent.com/stela-project/ts/master/images/ts.jpg" alt="Image of techhnology stack" width="600" height="auto">

[1] Stephen Few. “Dashboard Confusion, Perceptual edge”. In: (2004).

[2] Erik Duval. “Attention please!: learning analytics for visualization and recommendation”. In: Pro-
ceedings of the 1st International Conference on Learning Analytics and Knowledge. ACM. 2011,
pp. 9–17.

[3] Sven Charleer et al. “Creating effective learning analytics dashboards: Lessons lea

### Demo

Find a demo here: <a href="https://htmlpreview.github.io/?https://raw.githubusercontent.com/stela-project/ts/master/example/index.php/general/index.html" target="_blank">Go to Demo</a>

### Acknowledgments

This research project is co-funded by the European Commission Erasmus+ program, in the context of the project 562167-EPP-1-2015-1-BE-EPPKA3-PI-FORWARD. Please visit our website http://stela-project.eu.
