#
#===============================================================================
#
#         FILE:  sample.t
#
#  DESCRIPTION: test 
#
#        FILES:  ---
#         BUGS:  ---
#        NOTES:  ---
#       AUTHOR:  Weibin Yao (http://yaoweibin.cn/), yaoweibin@gmail.com
#      COMPANY:  
#      VERSION:  1.0
#      CREATED:  03/02/2010 03:18:28 PM
#     REVISION:  ---
#===============================================================================


# vi:filetype=perl

use lib 'lib';
use Test::Nginx::LWP;

plan tests => repeat_each() * 2 * blocks();

#no_diff;

run_tests();

__DATA__

=== TEST 1: the jvm_route status of AJP
--- http_config
    upstream tomcats{      
        server 127.0.0.1:8009 srun_id=jvm1;
        jvm_route $cookie_JSESSIONID reverse;
        keepalive 10;
    }

--- config
    location / {      
        ajp_pass tomcats;
    }

    location /status {
        jvm_route_status tomcats;
    }
--- request
    GET /status
--- response_body_like: ^upstream(.*)$
