<?php

defined('BASEPATH') OR exit('No direct script access allowed');

require 'vendor/autoload.php';

class General extends CI_Controller {
    private $elasticsearch;

    // All Use Cases
    public function __construct()
    {
        parent::__construct();
        $this->load->library('session');

        // Your own constructor code
        $this->elasticsearch = Elasticsearch\ClientBuilder::create()->build();

    }

    public function index()
    {
        $data = array('info' => $this->elasticsearch->info());

        $this->load->view('header');
        $this->load->view('general', $data);
        $this->load->view('footer');
    }

    public function phpinfo() {
        phpinfo();
    }
}
?>
