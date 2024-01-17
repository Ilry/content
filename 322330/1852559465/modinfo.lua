name ="Moving objects with mouse"
description = "Using this mod you can move game objects using mouse."
author = "Trololarion"
version = "1.7"

forumthread = ""

api_version = 10

configuration_options =
{
    {
        label="Move key",
        name="KEY",
        options=
        {
            {description="Ctrl+Alt",data="DEFAULT"},
			{description="Z",data="Z"},
            {description="X",data="X"},
            {description="C",data="C"},
            {description="V",data="V"},
            {description="T",data="T"},
            {description="G",data="G"},
            {description="H",data="H"},
            {description="B",data="B"},
			{description="I",data="I"},
			{description="O",data="O"},
			{description="P",data="P"},
			{description="J",data="J"},
			{description="K",data="K"},
			{description="L",data="L"},
			{description="N",data="N"},
			{description="M",data="M"},
        },
        default="DEFAULT",
    },
}

icon_atlas = "modicon.xml"
icon = "modicon.tex"

all_clients_require_mod = true
client_only_mod = false

dst_compatible = true
dont_starve_compatible = false
reign_of_giants_compatible = false
shipwrecked_compatible = false

server_filter_tags = {}