/*
original_author: Patricio Gonzalez Vivo
description: convert diffuse/specular/glossiness workflow to PBR metallic factor 
use: <float> toMetallic(<float3> diffuse, <float3> specular, <float> maxSpecular)
*/

#ifndef TOMETALLIC_MIN_REFLECTANCE
#define TOMETALLIC_MIN_REFLECTANCE 0.04
#endif

#ifndef FNC_TOMETALLIC
#define FNC_TOMETTALIC

float toMetallic(float3 diffuse, float3 specular, float maxSpecular) {
    float perceivedDiffuse = sqrt(0.299 * diffuse.r * diffuse.r + 0.587 * diffuse.g * diffuse.g + 0.114 * diffuse.b * diffuse.b);
    float perceivedSpecular = sqrt(0.299 * specular.r * specular.r + 0.587 * specular.g * specular.g + 0.114 * specular.b * specular.b);
    if (perceivedSpecular < TOMETALLIC_MIN_REFLECTANCE) {
        return 0.0;
    }
    float a = TOMETALLIC_MIN_REFLECTANCE;
    float b = perceivedDiffuse * (1.0 - maxSpecular) / (1.0 - TOMETALLIC_MIN_REFLECTANCE) + perceivedSpecular - 2.0 * TOMETALLIC_MIN_REFLECTANCE;
    float c = TOMETALLIC_MIN_REFLECTANCE - perceivedSpecular;
    float D = max(b * b - 4.0 * a * c, 0.0);
    return saturate((-b + sqrt(D)) / (2.0 * a));
}

float toMetallic(float3 diffuse, float3 specular) {
    float maxSpecula = max(max(specular.r, specular.g), specular.b);
    return toMetallic(diffuse, specular, maxSpecula);
}

#endif