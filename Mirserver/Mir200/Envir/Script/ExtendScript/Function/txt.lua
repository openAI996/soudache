({
    request: {
        url: "https://new.sharedchat.cc/codex/user/balance",
        method: "GET",
        headers: {
            "Authorization": "sk-d3dedef358d411f18dcf00163e012d40",
            "User-Agent": "cc-switch/1.0"
        }
    },
    extractor: function(response) {
        function cut2(value) {
            const num = Number(value || 0);
    const cut = Math.trunc(num * 100) / 100;
    return cut.toFixed(2);
    }

    const balance_3h = cut2(response.balance_3h);
    const balance_1d = cut2(response.balance_1d);

    return {
    isValid: response.is_active !== false,
    extra: `3H £:${balance_3h}£¨»’ £:${balance_1d}`,
    };
        }
        })