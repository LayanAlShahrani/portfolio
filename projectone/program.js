let txt = document.getElementById('writeEffect').textContent;
let txtEffect = document.getElementById('writeEffect');
let index = 1;

function write() {
    txtEffect.innerHTML = txt.slice(0, index);
    index++;

    if (index > txt.length) {
        setTimeout(() => {
            index = 1;
        }, 900); 
    }
}

setInterval(write,120);

function updateLocalTime() {
    let saudiArabiaTime = new Date(new Date().toLocaleString("en-US", {timeZone: "Asia/Riyadh"}));
    // Update the local time element
    document.getElementById("localTime").textContent = saudiArabiaTime.toLocaleTimeString();
}

updateLocalTime();
setInterval(updateLocalTime, 1000);


