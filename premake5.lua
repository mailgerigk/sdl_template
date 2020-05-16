workspace "workspace"
    location "build/make"
    architecture "x64"
    startproject "project"

    configurations
    {
        "Debug",
        "Release"
    }

binpath = "build/bin_x64"
objpath = "build/obj/%{cfg.buildcfg}"

project "project"
    location      "build/make"
    kind          "consoleapp"
    language      "c++"
    cppdialect    "c++17"
    staticruntime "on"

    targetdir(binpath)
    objdir   (objpath)
    debugdir (binpath)

    files
    {
        "src/**.hpp",
        "src/**.cpp",
    }

    includedirs
    {
        "src",
        "vendor/lib/SDL2-2.0.10/include",
    }

    links
    {
        "vendor/lib/SDL2-2.0.10/lib/x64/SDL2main.lib",
        "vendor/lib/SDL2-2.0.10/lib/x64/SDL2.lib",
    }
    
    filter "files:src/**.cpp"
        flags "ExcludeFromBuild"
        
    filter "files:src/main.cpp"
        removeflags "ExcludeFromBuild"

    filter "system:windows"
        systemversion "latest"

    filter "configurations:Debug"
        runtime  "Debug"
        symbols  "on"
        
        targetdir(binpath .. "d")
        debugdir (binpath .. "d")
        
        postbuildcommands 
        {
            "{COPY} ../../vendor/lib/SDL2-2.0.10/lib/x64 ../../" .. binpath .. "d",
        }

    filter "configurations:Release"
        runtime  "Release"
        optimize "on"
        
        postbuildcommands 
        {
            "{COPY} ../../vendor/lib/SDL2-2.0.10/lib/x64 ../../" .. binpath,
        }