const mathRequest = new XMLHttpRequest();
mathRequest.open('GET', '../wasm/math.wasm');
mathRequest.responseType = 'arraybuffer';
mathRequest.send();

const gpuRequest = new XMLHttpRequest();
gpuRequest.open('GET', '../wasm/gpu.wasm');
gpuRequest.responseType = 'arraybuffer';
gpuRequest.send();

request.onload = function () {
    var mathResponse = request.response;
    var gpuResponse = request.response;
    WebAssembly.instantiate(mathResponse, {
        env: {
            print: (result) => { console.log(`The result is ${result}.`); }
        }
    }).then(result => {
        var add = result.instance.exports.add;
        add(3, 5);
    });

    WebAssembly.instantiate(gpuResponse, {
        env: {
            print: (result) => { console.log(`The GPU details are ${result}.`); }
        }
    }).then(result => {
        var printGpuDetails = result.instance.exports.printGpuDetails;
        printGpuDetails();
    });
};
