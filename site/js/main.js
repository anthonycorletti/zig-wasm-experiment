const request = new XMLHttpRequest();
request.open('GET', '../wasm/main.wasm');
request.responseType = 'arraybuffer';
request.send();

request.onload = function () {
    var res = request.response;
    WebAssembly.instantiate(res, {
        env: {
            print: (result) => { console.log(`The result is ${result}.`); }
        }
    }).then(result => {
        var add = result.instance.exports.add;
        add(3, 5);
    });
};
