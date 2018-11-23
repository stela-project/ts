<div class="container-fluid">
    <div class="row">
        <div class="col">
            <h3>STELA-Project: Technology Stack - Dashboard Demo</h3>
        </div>
    </div>
</div>

<div class="container-fluid">
    <div class="row">
        <div class="col-xl-3">
        </div>
        <div class="col-xl-6">
            <table class="table table-bordered table-striped table-hover">
                <tr>
                    <th style="width:50%">Elasticsearch name:</th>
                    <td style="width:50%"><?php echo $info['name']; ?></td>
                </tr>
                <tr>
                    <th style="width:50%">Cluster name:</th>
                    <td style="width:50%"><?php echo $info['cluster_name']; ?></td>
                </tr>
                <tr>
                    <th style="width:50%">CLuster UUID:</th>
                    <td style="width:50%"><?php echo $info['cluster_uuid']; ?></td>
                </tr>
                <tr>
                    <th style="width:50%">Version number:</th>
                    <td style="width:50%"><?php echo $info['version']['number']; ?></td>
                </tr>
                <tr>
                    <th style="width:50%">Lucene version:</th>
                    <td style="width:50%"><?php echo $info['version']['lucene_version']; ?></td>
                </tr>
                <tr>
                    <th style="width:50%">Tagline:</th>
                    <td style="width:50%"><?php echo $info['tagline']; ?></td>
                </tr>
        </div>
        <div class="col-xl-3">
        </div>
    </div>
</div>
