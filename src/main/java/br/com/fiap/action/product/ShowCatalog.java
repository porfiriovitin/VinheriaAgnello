package br.com.fiap.action.product;

import br.com.fiap.action.Action;
import br.com.fiap.model.Wine;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

public class ShowCatalog implements Action {
    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
        List<Wine> mocWineList = new ArrayList<>(Arrays.asList(
                new Wine(1, "Brunello di Montalcino", "Itália", "Toscana", 450.00, "Sangiovese", "https://lh3.googleusercontent.com/aida-public/AB6AXuBFmhn7_eFS8LG7wX_RbHDiaCt0VjBBKn3Qo5oD75X5djCwzFHizW-uIii9nJMiHVPzdfbBh242NpCQqJYp7VVTx-N6N9pkolvdneU2Wc3UmijxOl3dwi4nK5TEWw-zkvBZ4utQHJiynDij0-HMrKQPuAOaz-Ifsy5bxl0HMPL9NV2gg35irbpPC8u_23v8H_MTRIVscrbydjb5m7HQFf9EvtT7TbmGABIywX2CE1Jneedz7_ZFCRJSK068IFZBGYbtchb_Be0BeEQ-"),
                new Wine(2, "Barolo DOCG", "Itália", "Piemonte", 380.00, "Nebbiolo", "https://lh3.googleusercontent.com/aida-public/AB6AXuCSJOvFoV30RcYoA3C35iLNOta9_5sCOdolkVhkYvYPynb33pnucjkCi3Qla3v2kd-yPJ2gWm-OXjTa1DuFk8ug3l5zkLAyISjY3U1D-qNfhTeI6yhFta8PkybHxDiuRyQiY_njO659VCHYGqsAC7gE5a9RXbhYtOkYnf5p9UEzFT5w01qpkZmieHuI5al-EW_LM5ZSesr9G3OQ_OlMpWe4_o2ELXynICySA7yz_MY0qBNOKV8g4XL1K6VBSyhJID0dCHH3--deVn3P"),
                new Wine(3, "Chianti Classico", "Itália", "Toscana", 120.00, "Sangiovese", "https://lh3.googleusercontent.com/aida-public/AB6AXuDBVU4cM5ejM16DbrwL3b_P1dHqGnkyNIhYv2748v157mWinqFCERaUokP4U11fZPF9tjnz2kpWHyYUrm_Wsn1VXwNmPCJKRCpvr9d0a0wFEYzFPrmfB1ZCysmVRnyIrHfTikR6oLQTLZys4uqGI9bL98Du5XcI1hZ8emkFIymwY4xAJwzQKXjOgBMMU0AawRWxjiewgv7WX8OlOm2eI1oKIXZkMTxxuh0hCTUnBkNjpb7FR91RRLTUkt4aaRAl135Da24RPXI2SbVr"),
                new Wine(4, "Amarone DOCG", "Itália", "Vêneto", 520.00, "Corvina", "https://lh3.googleusercontent.com/aida-public/AB6AXuCv6Ztz3HGMyc8AAa00KV7B6TWvg8k_I3mXpp1Cm0Yn7K7wdzJjJvqt50CWF5sDzsgylGWapmLf0TRx8a5TvREemjR02Ri4dBEn7LTIRrq5B0XPqrGqV6Arj3hpUC6WMYUC-bNgNhqFaRcjq-warDthWVwLd-MHUBG-l3i4Amd2u0JX2A5r_Eq11Gpzh0Q1PRwLVGJIxFFj6SftoqZfTqeF3rQJTJdwDFIhkLcqKF8hfyEPFpFQ2812T-y76M-A5uHVKDddi2wZMv4Q"),
                new Wine(5, "Chardonnay Reserve", "EUA", "Napa Valley", 290.00, "Chardonnay", "https://lh3.googleusercontent.com/aida-public/AB6AXuBDkvCcimKztR-dmlHPbyE20UWpWc3JBiw7eq7_p5cQTGuLheQilJWsXPyQx0Yy-4NQjm_cqBmoq32qKeirG5UF7cySeFoBtXMatzq0Z52IYgqkWwu9gfCK0ymYM03IvRgLTquvTrwwK4dmia5X3vjyFHznnNg75QzNAVeQU428HOS5qh0S7XNMdFxaT9CD75KvpaBlKwyqX8BWo2mM9WBAieU23rbEXfu0OSWzHvSgNBRGmyeGXz3iackJ2Kg5Sxkr-EvzNvSe2dC2"),
                new Wine(6, "Malbec Gran Reserva", "Argentina", "Mendoza", 215.00, "Malbec", "https://lh3.googleusercontent.com/aida-public/AB6AXuDGu4c04T53qh-WdhBAf3YX1JhOz3_G39fpgH5n89w0wPuUVtbuNDa0P2QInJAwmL2pJxEUVPhUjBYRRFU9ZuEUD2oepQKszV5hTsl--5_op_NVAC_5nYi2xEVNleCkUu2FHCEyPT2RzVkqVHWc335jT92t3t-uuWAsbVwK8lZzTAnj16LIA1_pxgNqPd92vA2vrbs8t0-7TqJ-DCnkBqPx3P3SzFqKH0JdCgLdRPeJBqJi7CeVDvR8YMeCT3LjC8hLDdUxPQ3qIPJz")
        ));
        request.setAttribute("wineList", mocWineList);

        return "catalog.jsp";
    }
}
