function getAjax(url, params) {
    return $.ajax({
        cache: false,
        dataFilter: function(data, type) {
            if (type !== "json") {
                return data;
            } else {
                var jsn = JSON.parse(data);
                var result;
                if ((typeof jsn.d) === "string")
                    result = JSON.parse("{" + jsn.d + "}");
                else
                    result = jsn.d;

                return JSON.stringify(result);
            }
        },
        type: "POST",
        async: true,
        url: url,
        data: JSON.stringify(params),
        contentType: "application/json; charset=utf8",
        dataType: "json",
        fail: function(data) {
            alert("failed ajax");
        }
});
}