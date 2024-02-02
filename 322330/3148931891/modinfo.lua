name = "水中木范围"
description = "改水中木绿荫范围"
author = "Xen"
version = "0"
forumthread = ""

api_version = 10

all_clients_require_mod = false
dst_compatible = true
client_only_mod = false
reign_of_giants_compatible = true
configuration_options = {{
    name = "范围",
    hover = "绿荫的范围",
    options = {{
        description = "10格地皮",
        hover = "10格地皮",
        data = 40
    }, {
        description = "15格地皮",
        hover = "15格地皮",
        data = 60
    }, {
        description = "20格地皮",
        hover = "20格地皮",
        data = 80
    }},
    default = 40
}}
