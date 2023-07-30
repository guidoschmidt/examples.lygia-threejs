fn lab2xyz(c : vec3<f32>) -> vec3<f32> {
    var f = vec3<f32>(0.0);
    f.y = (c.x + 16.0) / 116.0;
    f.x = c.y / 500.0 + f.y;
    f.z = f.y - c.z / 200.0;
    let c0 = f * f * f;
    let c1 = (f - 16.0 / 116.0) / 7.787;
    return vec3<f32>(95.047, 100.000, 108.883) * mix(c0, c1, step(f, vec3<f32>(0.206897)));
}
