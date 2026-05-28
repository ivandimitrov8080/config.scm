(define-module (config packages wttrbar-crates)
  #:use-module (guix build-system cargo)
  #:export (lookup-cargo-inputs))

;; All crate-source stubs for wttrbar and its transitive dependencies.

(define rust-addr2line-0.21.0
  (crate-source "addr2line" "0.21.0"
                "1jx0k3iwyqr8klqbzk6kjvr496yd94aspis10vwsj5wy7gib4c4a"))

(define rust-adler-1.0.2
  (crate-source "adler" "1.0.2"
                "1zim79cvzd5yrkzl3nyfx0avijwgk9fqv3yrscdy1cc79ih02qpj"))

(define rust-android-tzdata-0.1.1
  (crate-source "android-tzdata" "0.1.1"
                "1w7ynjxrfs97xg3qlcdns4kgfpwcdv824g611fq32cag4cdr96g9"))

(define rust-android-system-properties-0.1.5
  (crate-source "android_system_properties" "0.1.5"
                "04b3wrz12837j7mdczqd95b732gw5q7q66cv4yn4646lvccp57l1"))

(define rust-anstream-0.6.12
  (crate-source "anstream" "0.6.12"
                "0h5mwmsjfj1m6971zxs8grhq4jg8gxzib6rah5s0h7iqg18rpc4n"))

(define rust-anstyle-1.0.10
  (crate-source "anstyle" "1.0.10"
                "1yai2vppmd7zlvlrp9grwll60knrmscalf8l2qpfz8b7y5lkpk2m"))

(define rust-anstyle-parse-0.2.3
  (crate-source "anstyle-parse" "0.2.3"
                "134jhzrz89labrdwxxnjxqjdg06qvaflj1wkfnmyapwyldfwcnn7"))

(define rust-anstyle-query-1.0.2
  (crate-source "anstyle-query" "1.0.2"
                "0j3na4b1nma39g4x7cwvj009awxckjf3z2vkwhldgka44hqj72g2"))

(define rust-anstyle-wincon-3.0.2
  (crate-source "anstyle-wincon" "3.0.2"
                "19v0fv400bmp4niqpzxnhg83vz12mmqv7l2l8vi80qcdxj0lpm8w"))

(define rust-atomic-waker-1.1.2
  (crate-source "atomic-waker" "1.1.2"
                "1h5av1lw56m0jf0fd3bchxq8a30xv0b4wv8s4zkp4s0i7mfvs18m"))

(define rust-autocfg-1.1.0
  (crate-source "autocfg" "1.1.0"
                "1ylp3cb47ylzabimazvbz9ms6ap784zhb6syaz6c1jqpmcmq0s6l"))

(define rust-backtrace-0.3.69
  (crate-source "backtrace" "0.3.69"
                "0dsq23dhw4pfndkx2nsa1ml2g31idm7ss7ljxp8d57avygivg290"))

(define rust-base64-0.22.1
  (crate-source "base64" "0.22.1"
                "1imqzgh7bxcikp5vx3shqvw9j09g9ly0xr0jma0q66i52r7jbcvj"))

(define rust-bitflags-2.9.1
  (crate-source "bitflags" "2.9.1"
                "0rz9rpp5wywwqb3mxfkywh4drmzci2fch780q7lifbf6bsc5d3hv"))

(define rust-bumpalo-3.15.3
  (crate-source "bumpalo" "3.15.3"
                "0nsm985rzdcnx8lmy9px1179f8yc8jarg5n8aw8jldmvf6m898cf"))

(define rust-byteorder-1.5.0
  (crate-source "byteorder" "1.5.0"
                "0jzncxyf404mwqdbspihyzpkndfgda450l0893pz5xj685cg5l0z"))

(define rust-bytes-1.8.0
  (crate-source "bytes" "1.8.0"
                "1nnhpb7jlpj393qnjr1n9n6sgpl3w5ymrwl3pnjmrriam861bh4s"))

(define rust-cc-1.0.88
  (crate-source "cc" "1.0.88"
                "1p0w5ni5zh9464ai48i6d2lfki5af5cwwc8nwjk5b4fijg043wq2"))

(define rust-cfg-if-1.0.0
  (crate-source "cfg-if" "1.0.0"
                "1za0vb97n4brpzpv8lsbnzmq5r8f2b0cpqqr0sy8h5bn751xxwds"))

(define rust-cfg-aliases-0.2.1
  (crate-source "cfg_aliases" "0.2.1"
                "092pxdc1dbgjb6qvh83gk56rkic2n2ybm4yvy76cgynmzi3zwfk1"))

(define rust-chrono-0.4.38
  (crate-source "chrono" "0.4.38"
                "009l8vc5p8750vn02z30mblg4pv2qhkbfizhfwmzc6vpy5nr67x2"))

(define rust-clap-4.5.21
  (crate-source "clap" "4.5.21"
                "0kv0n5jbpfpl9xyags5lpyq5cccbx6g36s98lpgi8xbwbag4nfzv"))

(define rust-clap-builder-4.5.21
  (crate-source "clap_builder" "4.5.21"
                "1v10zx5v43yk7f4wwr0wxxlr1mx0k8c70lxa6aymwyyccym9aymi"))

(define rust-clap-derive-4.5.18
  (crate-source "clap_derive" "4.5.18"
                "1ardb26bvcpg72q9myr7yir3a8c83gx7vxk1cccabsd9n73s1ija"))

(define rust-clap-lex-0.7.0
  (crate-source "clap_lex" "0.7.0"
                "1kh1sckgq71kay2rrr149pl9gbsrvyccsq6xm5xpnq0cxnyqzk4q"))

(define rust-colorchoice-1.0.0
  (crate-source "colorchoice" "1.0.0"
                "1ix7w85kwvyybwi2jdkl3yva2r2bvdcc3ka2grjfzfgrapqimgxc"))

(define rust-core-foundation-0.10.1
  (crate-source "core-foundation" "0.10.1"
                "1xjns6dqf36rni2x9f47b65grxwdm20kwdg9lhmzdrrkwadcv9mj"))

(define rust-core-foundation-0.9.4
  (crate-source "core-foundation" "0.9.4"
                "13zvbbj07yk3b61b8fhwfzhy35535a583irf23vlcg59j7h9bqci"))

(define rust-core-foundation-sys-0.8.6
  (crate-source "core-foundation-sys" "0.8.6"
                "13w6sdf06r0hn7bx2b45zxsg1mm2phz34jikm6xc5qrbr6djpsh6"))

(define rust-encoding-rs-0.8.35
  (crate-source "encoding_rs" "0.8.35"
                "1wv64xdrr9v37rqqdjsyb8l8wzlcbab80ryxhrszvnj59wy0y0vm"))

(define rust-equivalent-1.0.2
  (crate-source "equivalent" "1.0.2"
                "03swzqznragy8n0x31lqc78g2af054jwivp7lkrbrc0khz74lyl7"))

(define rust-errno-0.3.13
  (crate-source "errno" "0.3.13"
                "1bd5g3srn66zr3bspac0150bvpg1s7zi6zwhwhlayivciz12m3kp"))

(define rust-fastrand-2.3.0
  (crate-source "fastrand" "2.3.0"
                "1ghiahsw1jd68df895cy5h3gzwk30hndidn3b682zmshpgmrx41p"))

(define rust-fnv-1.0.7
  (crate-source "fnv" "1.0.7"
                "1hc2mcqha06aibcaza94vbi81j6pr9a1bbxrxjfhc91zin8yr7iz"))

(define rust-foreign-types-0.3.2
  (crate-source "foreign-types" "0.3.2"
                "1cgk0vyd7r45cj769jym4a6s7vwshvd0z4bqrb92q1fwibmkkwzn"))

(define rust-foreign-types-shared-0.1.1
  (crate-source "foreign-types-shared" "0.1.1"
                "0jxgzd04ra4imjv8jgkmdq59kj8fsz6w4zxsbmlai34h26225c00"))

(define rust-form-urlencoded-1.2.1
  (crate-source "form_urlencoded" "1.2.1"
                "0milh8x7nl4f450s3ddhg57a3flcv6yq8hlkyk6fyr3mcb128dp1"))

(define rust-futures-channel-0.3.30
  (crate-source "futures-channel" "0.3.30"
                "0y6b7xxqdjm9hlcjpakcg41qfl7lihf6gavk8fyqijsxhvbzgj7a"))

(define rust-futures-core-0.3.30
  (crate-source "futures-core" "0.3.30"
                "07aslayrn3lbggj54kci0ishmd1pr367fp7iks7adia1p05miinz"))

(define rust-futures-io-0.3.30
  (crate-source "futures-io" "0.3.30"
                "1hgh25isvsr4ybibywhr4dpys8mjnscw4wfxxwca70cn1gi26im4"))

(define rust-futures-sink-0.3.30
  (crate-source "futures-sink" "0.3.30"
                "1dag8xyyaya8n8mh8smx7x6w2dpmafg2din145v973a3hw7f1f4z"))

(define rust-futures-task-0.3.30
  (crate-source "futures-task" "0.3.30"
                "013h1724454hj8qczp8vvs10qfiqrxr937qsrv6rhii68ahlzn1q"))

(define rust-futures-util-0.3.30
  (crate-source "futures-util" "0.3.30"
                "0j0xqhcir1zf2dcbpd421kgw6wvsk0rpxflylcysn1rlp3g02r1x"))

(define rust-getrandom-0.2.12
  (crate-source "getrandom" "0.2.12"
                "1d8jb9bv38nkwlqqdjcav6gxckgwc9g30pm3qq506rvncpm9400r"))

(define rust-getrandom-0.3.3
  (crate-source "getrandom" "0.3.3"
                "1x6jl875zp6b2b6qp9ghc84b0l76bvng2lvm8zfcmwjl7rb5w516"))

(define rust-gimli-0.28.1
  (crate-source "gimli" "0.28.1"
                "0lv23wc8rxvmjia3mcxc6hj9vkqnv1bqq0h8nzjcgf71mrxx6wa2"))

(define rust-h2-0.4.9
  (crate-source "h2" "0.4.9"
                "0cv6x0lndzxx59g49bhpl04zivfk0km9rzk9xs6iylrh80a9s93m"))

(define rust-hashbrown-0.15.4
  (crate-source "hashbrown" "0.15.4"
                "1mg045sm1nm00cwjm7ndi80hcmmv1v3z7gnapxyhd9qxc62sqwar"))

(define rust-heck-0.5.0
  (crate-source "heck" "0.5.0"
                "1sjmpsdl8czyh9ywl3qcsfsq9a307dg4ni2vnlwgnzzqhc4y0113"))

(define rust-http-1.1.0
  (crate-source "http" "1.1.0"
                "0n426lmcxas6h75c2cp25m933pswlrfjz10v91vc62vib2sdvf91"))

(define rust-http-body-1.0.1
  (crate-source "http-body" "1.0.1"
                "111ir5k2b9ihz5nr9cz7cwm7fnydca7dx4hc7vr16scfzghxrzhy"))

(define rust-http-body-util-0.1.2
  (crate-source "http-body-util" "0.1.2"
                "0kslwazg4400qnc2azkrgqqci0fppv12waicnsy5d8hncvbjjd3r"))

(define rust-httparse-1.8.0
  (crate-source "httparse" "1.8.0"
                "010rrfahm1jss3p022fqf3j3jmm72vhn4iqhykahb9ynpaag75yq"))

(define rust-hyper-1.5.0
  (crate-source "hyper" "1.5.0"
                "16pspkgizcnsr1qcpqvm5l45nfwk7244q9av56cqqwm40slg1gxv"))

(define rust-hyper-rustls-0.27.3
  (crate-source "hyper-rustls" "0.27.3"
                "0cxkph8hsmbz693a8ih2ciy7h0xbac844rpm981y6c0iqfsxpbq8"))

(define rust-hyper-tls-0.6.0
  (crate-source "hyper-tls" "0.6.0"
                "1q36x2yps6hhvxq5r7mc8ph9zz6xlb573gx0x3yskb0fi736y83h"))

(define rust-hyper-util-0.1.10
  (crate-source "hyper-util" "0.1.10"
                "1d1iwrkysjhq63pg54zk3vfby1j7zmxzm9zzyfr4lwvp0szcybfz"))

(define rust-iana-time-zone-0.1.60
  (crate-source "iana-time-zone" "0.1.60"
                "0hdid5xz3jznm04lysjm3vi93h3c523w0hcc3xba47jl3ddbpzz7"))

(define rust-iana-time-zone-haiku-0.1.2
  (crate-source "iana-time-zone-haiku" "0.1.2"
                "17r6jmj31chn7xs9698r122mapq85mfnv98bb4pg6spm0si2f67k"))

(define rust-idna-0.5.0
  (crate-source "idna" "0.5.0"
                "1xhjrcjqq0l5bpzvdgylvpkgk94panxgsirzhjnnqfdgc4a9nkb3"))

(define rust-indexmap-2.10.0
  (crate-source "indexmap" "2.10.0"
                "0qd6g26gxzl6dbf132w48fa8rr95glly3jhbk90i29726d9xhk7y"))

(define rust-ipnet-2.9.0
  (crate-source "ipnet" "2.9.0"
                "1hzrcysgwf0knf83ahb3535hrkw63mil88iqc6kjaryfblrqylcg"))

(define rust-itoa-1.0.10
  (crate-source "itoa" "1.0.10"
                "0k7xjfki7mnv6yzjrbnbnjllg86acmbnk4izz2jmm1hx2wd6v95i"))

(define rust-js-sys-0.3.68
  (crate-source "js-sys" "0.3.68"
                "1vm98fhnhs4w6yakchi9ip7ar95900k9vkr24a21qlwd6r5xlv20"))

(define rust-libc-0.2.162
  (crate-source "libc" "0.2.162"
                "1633a00yyx45kzx9r54fndvr8njsjqyr7zl12mzgsmgyczg8glhq"))

(define rust-linux-raw-sys-0.4.15
  (crate-source "linux-raw-sys" "0.4.15"
                "1aq7r2g7786hyxhv40spzf2nhag5xbw2axxc1k8z5k1dsgdm4v6j"))

(define rust-log-0.4.20
  (crate-source "log" "0.4.20"
                "13rf7wphnwd61vazpxr7fiycin6cb1g8fmvgqg18i464p0y1drmm"))

(define rust-memchr-2.7.1
  (crate-source "memchr" "2.7.1"
                "0jf1kicqa4vs9lyzj4v4y1p90q0dh87hvhsdd5xvhnp527sw8gaj"))

(define rust-mime-0.3.17
  (crate-source "mime" "0.3.17"
                "16hkibgvb9klh0w0jk5crr5xv90l3wlf77ggymzjmvl1818vnxv8"))

(define rust-miniz-oxide-0.7.2
  (crate-source "miniz_oxide" "0.7.2"
                "19qlxb21s6kabgqq61mk7kd1qk2invyygj076jz6i1gj2lz1z0cx"))

(define rust-mio-0.8.10
  (crate-source "mio" "0.8.10"
                "02gyaxvaia9zzi4drrw59k9s0j6pa5d1y2kv7iplwjipdqlhngcg"))

(define rust-native-tls-0.2.14
  (crate-source "native-tls" "0.2.14"
                "03hga800x8bzkp8h7frnm7yp545dwwawgmaq673vx7byk1139pl7"))

(define rust-num-traits-0.2.18
  (crate-source "num-traits" "0.2.18"
                "0yjib8p2p9kzmaz48xwhs69w5dh1wipph9jgnillzd2x33jz03fs"))

(define rust-object-0.32.2
  (crate-source "object" "0.32.2"
                "0hc4cjwyngiy6k51hlzrlsxgv5z25vv7c2cp0ky1lckfic0259m6"))

(define rust-once-cell-1.19.0
  (crate-source "once_cell" "1.19.0"
                "14kvw7px5z96dk4dwdm1r9cqhhy2cyj1l5n5b29mynbb8yr15nrz"))

(define rust-openssl-0.10.72
  (crate-source "openssl" "0.10.72"
                "1np54pm6hw512rmfjv3kc54h8yvf51mdlm8a8cc33xx1b1yympzy"))

(define rust-openssl-macros-0.1.1
  (crate-source "openssl-macros" "0.1.1"
                "173xxvfc63rr5ybwqwylsir0vq6xsj4kxiv4hmg4c3vscdmncj59"))

(define rust-openssl-probe-0.1.6
  (crate-source "openssl-probe" "0.1.6"
                "0bl52x55laalqb707k009h8kfawliwp992rlsvkzy49n47p2fpnh"))

(define rust-openssl-sys-0.9.107
  (crate-source "openssl-sys" "0.9.107"
                "01yydv8yaagdnapvair8b6rggf225lwb854h99s9qx44rnd9g242"))

(define rust-percent-encoding-2.3.1
  (crate-source "percent-encoding" "2.3.1"
                "0gi8wgx0dcy8rnv1kywdv98lwcx67hz0a0zwpib5v2i08r88y573"))

(define rust-pin-project-lite-0.2.13
  (crate-source "pin-project-lite" "0.2.13"
                "0n0bwr5qxlf0mhn2xkl36sy55118s9qmvx2yl5f3ixkb007lbywa"))

(define rust-pin-utils-0.1.0
  (crate-source "pin-utils" "0.1.0"
                "117ir7vslsl2z1a7qzhws4pd01cg2d3338c47swjyvqv2n60v1wb"))

(define rust-pkg-config-0.3.32
  (crate-source "pkg-config" "0.3.32"
                "0k4h3gnzs94sjb2ix6jyksacs52cf1fanpwsmlhjnwrdnp8dppby"))

(define rust-ppv-lite86-0.2.20
  (crate-source "ppv-lite86" "0.2.20"
                "017ax9ssdnpww7nrl1hvqh2lzncpv04nnsibmnw9nxjnaqlpp5bp"))

(define rust-proc-macro2-1.0.78
  (crate-source "proc-macro2" "1.0.78"
                "1bjak27pqdn4f4ih1c9nr3manzyavsgqmf76ygw9k76q8pb2lhp2"))

(define rust-pure-rust-locales-0.8.1
  (crate-source "pure-rust-locales" "0.8.1"
                "0fkkwggiq2053rmiah2h06dz6w3yhy9pa82g30vy3sbcmqcgv40i"))

(define rust-quinn-0.11.5
  (crate-source "quinn" "0.11.5"
                "1146h9wkn5bb8l1mllnw7s1hkvg0iykg1i3x881p5bndwgfmyz4c"))

(define rust-quinn-proto-0.11.8
  (crate-source "quinn-proto" "0.11.8"
                "19m4219ybsma7kkz79j721lzhy3vgfqfwwxvc40rsf3zrp9axpzs"))

(define rust-quinn-udp-0.5.7
  (crate-source "quinn-udp" "0.5.7"
                "1nj3yb1zw4bnw2m4phh8ajd3q16nrk56lan8r8aknw87d1n64nkx"))

(define rust-quote-1.0.35
  (crate-source "quote" "1.0.35"
                "1vv8r2ncaz4pqdr78x7f138ka595sp2ncr1sa2plm4zxbsmwj7i9"))

(define rust-r-efi-5.3.0
  (crate-source "r-efi" "5.3.0"
                "03sbfm3g7myvzyylff6qaxk4z6fy76yv860yy66jiswc2m6b7kb9"))

(define rust-rand-0.8.5
  (crate-source "rand" "0.8.5"
                "013l6931nn7gkc23jz5mm3qdhf93jjf0fg64nz2lp4i51qd8vbrl"))

(define rust-rand-chacha-0.3.1
  (crate-source "rand_chacha" "0.3.1"
                "123x2adin558xbhvqb8w4f6syjsdkmqff8cxwhmjacpsl1ihmhg6"))

(define rust-rand-core-0.6.4
  (crate-source "rand_core" "0.6.4"
                "0b4j2v4cb5krak1pv6kakv4sz6xcwbrmy2zckc32hsigbrwy82zc"))

(define rust-reqwest-0.12.9
  (crate-source "reqwest" "0.12.9"
                "0vq40h75fmrkfjyyjxl84g0pzjzz0n989ag1cajy17g78spn4z57"))

(define rust-ring-0.17.8
  (crate-source "ring" "0.17.8"
                "03fwlb1ssrmfxdckvqv033pfmk01rhx9ynwi7r186dcfcp5s8zy1"))

(define rust-rustc-demangle-0.1.23
  (crate-source "rustc-demangle" "0.1.23"
                "0xnbk2bmyzshacjm2g1kd4zzv2y2az14bw3sjccq5qkpmsfvn9nn"))

(define rust-rustc-hash-2.0.0
  (crate-source "rustc-hash" "2.0.0"
                "0lni0lf846bzrf3jvci6jaf4142n1mdqxvcpczk5ch9pfgyk8c2q"))

(define rust-rustix-0.38.44
  (crate-source "rustix" "0.38.44"
                "0m61v0h15lf5rrnbjhcb9306bgqrhskrqv7i1n0939dsw8dbrdgx"))

(define rust-rustls-0.23.29
  (crate-source "rustls" "0.23.29"
                "1lcvzvzqk8xx8jzg0x5v3mkqgwkwr7v6zdq8zw8rp6xj74h3i494"))

(define rust-rustls-native-certs-0.8.1
  (crate-source "rustls-native-certs" "0.8.1"
                "1ls7laa3748mkn23fmi3g4mlwk131lx6chq2lyc8v2mmabfz5kvz"))

(define rust-rustls-pemfile-2.2.0
  (crate-source "rustls-pemfile" "2.2.0"
                "0l3f3mrfkgdjrava7ibwzgwc4h3dljw3pdkbsi9rkwz3zvji9qyw"))

(define rust-rustls-pki-types-1.12.0
  (crate-source "rustls-pki-types" "1.12.0"
                "0yawbdpix8jif6s8zj1p2hbyb7y3bj66fhx0y7hyf4qh4964m6i2"))

(define rust-rustls-webpki-0.103.4
  (crate-source "rustls-webpki" "0.103.4"
                "1z4jmmgasjgk9glb160a66bshvgifa64mgfjrkqp7dy1w158h5qa"))

(define rust-ryu-1.0.17
  (crate-source "ryu" "1.0.17"
                "188vrsh3zlnl5xl7lw0rp2sc0knpx8yaqpwvr648b6h12v4rfrp8"))

(define rust-schannel-0.1.27
  (crate-source "schannel" "0.1.27"
                "0gbbhy28v72kd5iina0z2vcdl3vz63mk5idvkzn5r52z6jmfna8z"))

(define rust-security-framework-2.11.1
  (crate-source "security-framework" "2.11.1"
                "00ldclwx78dm61v7wkach9lcx76awlrv0fdgjdwch4dmy12j4yw9"))

(define rust-security-framework-3.2.0
  (crate-source "security-framework" "3.2.0"
                "05mkrddi9i18h9p098d0iimqv1xxz0wd8mbgpbvh9jj67x0205r7"))

(define rust-security-framework-sys-2.14.0
  (crate-source "security-framework-sys" "2.14.0"
                "0chwn01qrnvs59i5220bymd38iddy4krbnmfnhf4k451aqfj7ns9"))

(define rust-serde-1.0.197
  (crate-source "serde" "1.0.197"
                "1qjcxqd3p4yh5cmmax9q4ics1zy34j5ij32cvjj5dc5rw5rwic9z"))

(define rust-serde-derive-1.0.197
  (crate-source "serde_derive" "1.0.197"
                "02v1x0sdv8qy06lpr6by4ar1n3jz3hmab15cgimpzhgd895v7c3y"))

(define rust-serde-json-1.0.133
  (crate-source "serde_json" "1.0.133"
                "0xz3bswa527wln3fy0qb7y081nx3cp5yy1ggjhi6n5mrfcjfpz67"))

(define rust-serde-urlencoded-0.7.1
  (crate-source "serde_urlencoded" "0.7.1"
                "1zgklbdaysj3230xivihs30qi5vkhigg323a9m62k8jwf4a1qjfk"))

(define rust-slab-0.4.9
  (crate-source "slab" "0.4.9"
                "0rxvsgir0qw5lkycrqgb1cxsvxzjv9bmx73bk5y42svnzfba94lg"))

(define rust-smallvec-1.13.2
  (crate-source "smallvec" "1.13.2"
                "0rsw5samawl3wsw6glrsb127rx6sh89a8wyikicw6dkdcjd1lpiw"))

(define rust-socket2-0.5.6
  (crate-source "socket2" "0.5.6"
                "0w98g7dh9m74vpxln401hl4knpjzrx7jhng7cbh46x9vm70dkzq5"))

(define rust-spin-0.9.8
  (crate-source "spin" "0.9.8"
                "0rvam5r0p3a6qhc18scqpvpgb3ckzyqxpgdfyjnghh8ja7byi039"))

(define rust-strsim-0.11.0
  (crate-source "strsim" "0.11.0"
                "00gsdp2x1gkkxsbjxgrjyil2hsbdg49bwv8q2y1f406dwk4p7q2y"))

(define rust-subtle-2.6.1
  (crate-source "subtle" "2.6.1"
                "14ijxaymghbl1p0wql9cib5zlwiina7kall6w7g89csprkgbvhhk"))

(define rust-syn-2.0.51
  (crate-source "syn" "2.0.51"
                "0v6n8nrzg241wp5lwiw7jl6am046b4lcc1l47gjlms8m8pcigdka"))

(define rust-sync-wrapper-1.0.1
  (crate-source "sync_wrapper" "1.0.1"
                "150k6lwvr4nl237ngsz8fj5j78k712m4bggrfyjsidllraz5l1m7"))

(define rust-system-configuration-0.6.1
  (crate-source "system-configuration" "0.6.1"
                "0sxslml567zm0v8g732314vd2gk9sd3k4xj22xk6p64xir29v1rw"))

(define rust-system-configuration-sys-0.6.0
  (crate-source "system-configuration-sys" "0.6.0"
                "1i5sqrmgy58l4704hibjbl36hclddglh73fb3wx95jnmrq81n7cf"))

(define rust-tempfile-3.17.1
  (crate-source "tempfile" "3.17.1"
                "0c52ggq5vy5mzgk5ly36cgzs1cig3cv6r1jarijmzxgkn6na1r92"))

(define rust-thiserror-1.0.65
  (crate-source "thiserror" "1.0.65"
                "1mdkawq9l9p02zvq7y4py739rjk9wk2ha27mbsb3i6sdb7csn4ax"))

(define rust-thiserror-impl-1.0.65
  (crate-source "thiserror-impl" "1.0.65"
                "00l6gyrx6qlm1d7if3dcfl2sl0mg8k21caknkpk7glnb481pfwdf"))

(define rust-tinyvec-1.6.0
  (crate-source "tinyvec" "1.6.0"
                "0l6bl2h62a5m44jdnpn7lmj14rd44via8180i7121fvm73mmrk47"))

(define rust-tinyvec-macros-0.1.1
  (crate-source "tinyvec_macros" "0.1.1"
                "081gag86208sc3y6sdkshgw3vysm5d34p431dzw0bshz66ncng0z"))

(define rust-tokio-1.36.0
  (crate-source "tokio" "1.36.0"
                "0c89p36zbd4abr1z3l5mipp43x7z4c9b4vp4s6r8y0gs2mjmya31"))

(define rust-tokio-native-tls-0.3.1
  (crate-source "tokio-native-tls" "0.3.1"
                "1wkfg6zn85zckmv4im7mv20ca6b1vmlib5xwz9p7g19wjfmpdbmv"))

(define rust-tokio-rustls-0.26.0
  (crate-source "tokio-rustls" "0.26.0"
                "1m00czrmk8x7pdjnz10a3da3i1d0sdf9j9vfp5dnk5ss1q6w8yqc"))

(define rust-tokio-util-0.7.15
  (crate-source "tokio-util" "0.7.15"
                "1pypd9lm1fdnpw0779pqvc16qqrxjy63dgfm20ajhpbdmnlkk9b6"))

(define rust-tower-service-0.3.2
  (crate-source "tower-service" "0.3.2"
                "0lmfzmmvid2yp2l36mbavhmqgsvzqf7r2wiwz73ml4xmwaf1rg5n"))

(define rust-tracing-0.1.40
  (crate-source "tracing" "0.1.40"
                "1vv48dac9zgj9650pg2b4d0j3w6f3x9gbggf43scq5hrlysklln3"))

(define rust-tracing-core-0.1.32
  (crate-source "tracing-core" "0.1.32"
                "0m5aglin3cdwxpvbg6kz0r9r0k31j48n0kcfwsp6l49z26k3svf0"))

(define rust-try-lock-0.2.5
  (crate-source "try-lock" "0.2.5"
                "0jqijrrvm1pyq34zn1jmy2vihd4jcrjlvsh4alkjahhssjnsn8g4"))

(define rust-unicode-bidi-0.3.15
  (crate-source "unicode-bidi" "0.3.15"
                "0xcdxm7h0ydyprwpcbh436rbs6s6lph7f3gr527lzgv6lw053y88"))

(define rust-unicode-ident-1.0.12
  (crate-source "unicode-ident" "1.0.12"
                "0jzf1znfpb2gx8nr8mvmyqs1crnv79l57nxnbiszc7xf7ynbjm1k"))

(define rust-unicode-normalization-0.1.23
  (crate-source "unicode-normalization" "0.1.23"
                "1x81a50h2zxigj74b9bqjsirxxbyhmis54kg600xj213vf31cvd5"))

(define rust-untrusted-0.9.0
  (crate-source "untrusted" "0.9.0"
                "1ha7ib98vkc538x0z60gfn0fc5whqdd85mb87dvisdcaifi6vjwf"))

(define rust-url-2.5.0
  (crate-source "url" "2.5.0"
                "0cs65961miawncdg2z20171w0vqrmraswv2ihdpd8lxp7cp31rii"))

(define rust-utf8parse-0.2.1
  (crate-source "utf8parse" "0.2.1"
                "02ip1a0az0qmc2786vxk2nqwsgcwf17d3a38fkf0q7hrmwh9c6vi"))

(define rust-vcpkg-0.2.15
  (crate-source "vcpkg" "0.2.15"
                "09i4nf5y8lig6xgj3f7fyrvzd3nlaw4znrihw8psidvv5yk4xkdc"))

(define rust-want-0.3.1
  (crate-source "want" "0.3.1"
                "03hbfrnvqqdchb5kgxyavb9jabwza0dmh2vw5kg0dq8rxl57d9xz"))

(define rust-wasi-0.11.0+wasi-snapshot-preview1
  (crate-source "wasi" "0.11.0+wasi-snapshot-preview1"
                "08z4hxwkpdpalxjps1ai9y7ihin26y9f476i53dv98v45gkqg3cw"))

(define rust-wasi-0.14.2+wasi-0.2.4
  (crate-source "wasi" "0.14.2+wasi-0.2.4"
                "1cwcqjr3dgdq8j325awgk8a715h0hg0f7jqzsb077n4qm6jzk0wn"))

(define rust-wasm-bindgen-0.2.91
  (crate-source "wasm-bindgen" "0.2.91"
                "0zwbb07ln4m5hh6axamc701nnj090nd66syxbf6bagzf189j9qf1"))

(define rust-wasm-bindgen-backend-0.2.91
  (crate-source "wasm-bindgen-backend" "0.2.91"
                "02zpi9sjzhd8kfv1yj9m1bs4a41ik9ii5bc8hjf60arm1j8f3ry9"))

(define rust-wasm-bindgen-futures-0.4.41
  (crate-source "wasm-bindgen-futures" "0.4.41"
                "15zd36y0jpzvh18x963hd905rlpk2cxp918r6db0xsnfc4zrqyw7"))

(define rust-wasm-bindgen-macro-0.2.91
  (crate-source "wasm-bindgen-macro" "0.2.91"
                "1va6dilw9kcnvsg5043h5b9mwc5sgq0lyhj9fif2n62qsgigj2mk"))

(define rust-wasm-bindgen-macro-support-0.2.91
  (crate-source "wasm-bindgen-macro-support" "0.2.91"
                "0rlyl3yzwbcnc691mvx78m1wbqf1qs52mlc3g88bh7ihwrdk4bv4"))

(define rust-wasm-bindgen-shared-0.2.91
  (crate-source "wasm-bindgen-shared" "0.2.91"
                "0f4qmjv57ppwi4xpdxgcd77vz9vmvlrnybg8dj430hzhvk96n62g"))

(define rust-web-sys-0.3.68
  (crate-source "web-sys" "0.3.68"
                "0il4nbsf782l5y1jb7s75vc7214a19vh7z65bfrwwykzd03mjmln"))

(define rust-windows-core-0.52.0
  (crate-source "windows-core" "0.52.0"
                "1nc3qv7sy24x0nlnb32f7alzpd6f72l4p24vl65vydbyil669ark"))

(define rust-windows-registry-0.2.0
  (crate-source "windows-registry" "0.2.0"
                "1c04923fq0rbvl3z0h67xr6rh2fgwkizhclhqv0j79i0nwdh0074"))

(define rust-windows-result-0.2.0
  (crate-source "windows-result" "0.2.0"
                "03mf2z1xcy2slhhsm15z24p76qxgm2m74xdjp8bihyag47c4640x"))

(define rust-windows-strings-0.1.0
  (crate-source "windows-strings" "0.1.0"
                "042dxvi3133f7dyi2pgcvknwkikk47k8bddwxbq5s0l6qhjv3nac"))

(define rust-windows-sys-0.48.0
  (crate-source "windows-sys" "0.48.0"
                "1aan23v5gs7gya1lc46hqn9mdh8yph3fhxmhxlw36pn6pqc28zb7"))

(define rust-windows-sys-0.52.0
  (crate-source "windows-sys" "0.52.0"
                "0gd3v4ji88490zgb6b5mq5zgbvwv7zx1ibn8v3x83rwcdbryaar8"))

(define rust-windows-sys-0.59.0
  (crate-source "windows-sys" "0.59.0"
                "0fw5672ziw8b3zpmnbp9pdv1famk74f1l9fcbc3zsrzdg56vqf0y"))

(define rust-windows-targets-0.48.5
  (crate-source "windows-targets" "0.48.5"
                "034ljxqshifs1lan89xwpcy1hp0lhdh4b5n0d2z4fwjx2piacbws"))

(define rust-windows-targets-0.52.6
  (crate-source "windows-targets" "0.52.6"
                "0wwrx625nwlfp7k93r2rra568gad1mwd888h1jwnl0vfg5r4ywlv"))

(define rust-windows-aarch64-gnullvm-0.48.5
  (crate-source "windows_aarch64_gnullvm" "0.48.5"
                "1n05v7qblg1ci3i567inc7xrkmywczxrs1z3lj3rkkxw18py6f1b"))

(define rust-windows-aarch64-gnullvm-0.52.6
  (crate-source "windows_aarch64_gnullvm" "0.52.6"
                "1lrcq38cr2arvmz19v32qaggvj8bh1640mdm9c2fr877h0hn591j"))

(define rust-windows-aarch64-msvc-0.48.5
  (crate-source "windows_aarch64_msvc" "0.48.5"
                "1g5l4ry968p73g6bg6jgyvy9lb8fyhcs54067yzxpcpkf44k2dfw"))

(define rust-windows-aarch64-msvc-0.52.6
  (crate-source "windows_aarch64_msvc" "0.52.6"
                "0sfl0nysnz32yyfh773hpi49b1q700ah6y7sacmjbqjjn5xjmv09"))

(define rust-windows-i686-gnu-0.48.5
  (crate-source "windows_i686_gnu" "0.48.5"
                "0gklnglwd9ilqx7ac3cn8hbhkraqisd0n83jxzf9837nvvkiand7"))

(define rust-windows-i686-gnu-0.52.6
  (crate-source "windows_i686_gnu" "0.52.6"
                "02zspglbykh1jh9pi7gn8g1f97jh1rrccni9ivmrfbl0mgamm6wf"))

(define rust-windows-i686-gnullvm-0.52.6
  (crate-source "windows_i686_gnullvm" "0.52.6"
                "0rpdx1537mw6slcpqa0rm3qixmsb79nbhqy5fsm3q2q9ik9m5vhf"))

(define rust-windows-i686-msvc-0.48.5
  (crate-source "windows_i686_msvc" "0.48.5"
                "01m4rik437dl9rdf0ndnm2syh10hizvq0dajdkv2fjqcywrw4mcg"))

(define rust-windows-i686-msvc-0.52.6
  (crate-source "windows_i686_msvc" "0.52.6"
                "0rkcqmp4zzmfvrrrx01260q3xkpzi6fzi2x2pgdcdry50ny4h294"))

(define rust-windows-x86-64-gnu-0.48.5
  (crate-source "windows_x86_64_gnu" "0.48.5"
                "13kiqqcvz2vnyxzydjh73hwgigsdr2z1xpzx313kxll34nyhmm2k"))

(define rust-windows-x86-64-gnu-0.52.6
  (crate-source "windows_x86_64_gnu" "0.52.6"
                "0y0sifqcb56a56mvn7xjgs8g43p33mfqkd8wj1yhrgxzma05qyhl"))

(define rust-windows-x86-64-gnullvm-0.48.5
  (crate-source "windows_x86_64_gnullvm" "0.48.5"
                "1k24810wfbgz8k48c2yknqjmiigmql6kk3knmddkv8k8g1v54yqb"))

(define rust-windows-x86-64-gnullvm-0.52.6
  (crate-source "windows_x86_64_gnullvm" "0.52.6"
                "03gda7zjx1qh8k9nnlgb7m3w3s1xkysg55hkd1wjch8pqhyv5m94"))

(define rust-windows-x86-64-msvc-0.48.5
  (crate-source "windows_x86_64_msvc" "0.48.5"
                "0f4mdp895kkjh9zv8dxvn4pc10xr7839lf5pa9l0193i2pkgr57d"))

(define rust-windows-x86-64-msvc-0.52.6
  (crate-source "windows_x86_64_msvc" "0.52.6"
                "1v7rb5cibyzx8vak29pdrk8nx9hycsjs4w0jgms08qk49jl6v7sq"))

(define rust-wit-bindgen-rt-0.39.0
  (crate-source "wit-bindgen-rt" "0.39.0"
                "1hd65pa5hp0nl664m94bg554h4zlhrzmkjsf6lsgsb7yc4734hkg"))

(define rust-zerocopy-0.7.35
  (crate-source "zerocopy" "0.7.35"
                "1w36q7b9il2flg0qskapgi9ymgg7p985vniqd09vi0mwib8lz6qv"))

(define rust-zerocopy-derive-0.7.35
  (crate-source "zerocopy-derive" "0.7.35"
                "0gnf2ap2y92nwdalzz3x7142f2b83sni66l39vxp2ijd6j080kzs"))

(define rust-zeroize-1.8.1
  (crate-source "zeroize" "1.8.1"
                "1pjdrmjwmszpxfd7r860jx54cyk94qk59x13sc307cvr5256glyf"))

(define-cargo-inputs lookup-cargo-inputs
  (wttrbar =>
           (list
              rust-addr2line-0.21.0
              rust-adler-1.0.2
              rust-android-tzdata-0.1.1
              rust-android-system-properties-0.1.5
              rust-anstream-0.6.12
              rust-anstyle-1.0.10
              rust-anstyle-parse-0.2.3
              rust-anstyle-query-1.0.2
              rust-anstyle-wincon-3.0.2
              rust-atomic-waker-1.1.2
              rust-autocfg-1.1.0
              rust-backtrace-0.3.69
              rust-base64-0.22.1
              rust-bitflags-2.9.1
              rust-bumpalo-3.15.3
              rust-byteorder-1.5.0
              rust-bytes-1.8.0
              rust-cc-1.0.88
              rust-cfg-if-1.0.0
              rust-cfg-aliases-0.2.1
              rust-chrono-0.4.38
              rust-clap-4.5.21
              rust-clap-builder-4.5.21
              rust-clap-derive-4.5.18
              rust-clap-lex-0.7.0
              rust-colorchoice-1.0.0
              rust-core-foundation-0.10.1
              rust-core-foundation-0.9.4
              rust-core-foundation-sys-0.8.6
              rust-encoding-rs-0.8.35
              rust-equivalent-1.0.2
              rust-errno-0.3.13
              rust-fastrand-2.3.0
              rust-fnv-1.0.7
              rust-foreign-types-0.3.2
              rust-foreign-types-shared-0.1.1
              rust-form-urlencoded-1.2.1
              rust-futures-channel-0.3.30
              rust-futures-core-0.3.30
              rust-futures-io-0.3.30
              rust-futures-sink-0.3.30
              rust-futures-task-0.3.30
              rust-futures-util-0.3.30
              rust-getrandom-0.2.12
              rust-getrandom-0.3.3
              rust-gimli-0.28.1
              rust-h2-0.4.9
              rust-hashbrown-0.15.4
              rust-heck-0.5.0
              rust-http-1.1.0
              rust-http-body-1.0.1
              rust-http-body-util-0.1.2
              rust-httparse-1.8.0
              rust-hyper-1.5.0
              rust-hyper-rustls-0.27.3
              rust-hyper-tls-0.6.0
              rust-hyper-util-0.1.10
              rust-iana-time-zone-0.1.60
              rust-iana-time-zone-haiku-0.1.2
              rust-idna-0.5.0
              rust-indexmap-2.10.0
              rust-ipnet-2.9.0
              rust-itoa-1.0.10
              rust-js-sys-0.3.68
              rust-libc-0.2.162
              rust-linux-raw-sys-0.4.15
              rust-log-0.4.20
              rust-memchr-2.7.1
              rust-mime-0.3.17
              rust-miniz-oxide-0.7.2
              rust-mio-0.8.10
              rust-native-tls-0.2.14
              rust-num-traits-0.2.18
              rust-object-0.32.2
              rust-once-cell-1.19.0
              rust-openssl-0.10.72
              rust-openssl-macros-0.1.1
              rust-openssl-probe-0.1.6
              rust-openssl-sys-0.9.107
              rust-percent-encoding-2.3.1
              rust-pin-project-lite-0.2.13
              rust-pin-utils-0.1.0
              rust-pkg-config-0.3.32
              rust-ppv-lite86-0.2.20
              rust-proc-macro2-1.0.78
              rust-pure-rust-locales-0.8.1
              rust-quinn-0.11.5
              rust-quinn-proto-0.11.8
              rust-quinn-udp-0.5.7
              rust-quote-1.0.35
              rust-r-efi-5.3.0
              rust-rand-0.8.5
              rust-rand-chacha-0.3.1
              rust-rand-core-0.6.4
              rust-reqwest-0.12.9
              rust-ring-0.17.8
              rust-rustc-demangle-0.1.23
              rust-rustc-hash-2.0.0
              rust-rustix-0.38.44
              rust-rustls-0.23.29
              rust-rustls-native-certs-0.8.1
              rust-rustls-pemfile-2.2.0
              rust-rustls-pki-types-1.12.0
              rust-rustls-webpki-0.103.4
              rust-ryu-1.0.17
              rust-schannel-0.1.27
              rust-security-framework-2.11.1
              rust-security-framework-3.2.0
              rust-security-framework-sys-2.14.0
              rust-serde-1.0.197
              rust-serde-derive-1.0.197
              rust-serde-json-1.0.133
              rust-serde-urlencoded-0.7.1
              rust-slab-0.4.9
              rust-smallvec-1.13.2
              rust-socket2-0.5.6
              rust-spin-0.9.8
              rust-strsim-0.11.0
              rust-subtle-2.6.1
              rust-syn-2.0.51
              rust-sync-wrapper-1.0.1
              rust-system-configuration-0.6.1
              rust-system-configuration-sys-0.6.0
              rust-tempfile-3.17.1
              rust-thiserror-1.0.65
              rust-thiserror-impl-1.0.65
              rust-tinyvec-1.6.0
              rust-tinyvec-macros-0.1.1
              rust-tokio-1.36.0
              rust-tokio-native-tls-0.3.1
              rust-tokio-rustls-0.26.0
              rust-tokio-util-0.7.15
              rust-tower-service-0.3.2
              rust-tracing-0.1.40
              rust-tracing-core-0.1.32
              rust-try-lock-0.2.5
              rust-unicode-bidi-0.3.15
              rust-unicode-ident-1.0.12
              rust-unicode-normalization-0.1.23
              rust-untrusted-0.9.0
              rust-url-2.5.0
              rust-utf8parse-0.2.1
              rust-vcpkg-0.2.15
              rust-want-0.3.1
              rust-wasi-0.11.0+wasi-snapshot-preview1
              rust-wasi-0.14.2+wasi-0.2.4
              rust-wasm-bindgen-0.2.91
              rust-wasm-bindgen-backend-0.2.91
              rust-wasm-bindgen-futures-0.4.41
              rust-wasm-bindgen-macro-0.2.91
              rust-wasm-bindgen-macro-support-0.2.91
              rust-wasm-bindgen-shared-0.2.91
              rust-web-sys-0.3.68
              rust-windows-core-0.52.0
              rust-windows-registry-0.2.0
              rust-windows-result-0.2.0
              rust-windows-strings-0.1.0
              rust-windows-sys-0.48.0
              rust-windows-sys-0.52.0
              rust-windows-sys-0.59.0
              rust-windows-targets-0.48.5
              rust-windows-targets-0.52.6
              rust-windows-aarch64-gnullvm-0.48.5
              rust-windows-aarch64-gnullvm-0.52.6
              rust-windows-aarch64-msvc-0.48.5
              rust-windows-aarch64-msvc-0.52.6
              rust-windows-i686-gnu-0.48.5
              rust-windows-i686-gnu-0.52.6
              rust-windows-i686-gnullvm-0.52.6
              rust-windows-i686-msvc-0.48.5
              rust-windows-i686-msvc-0.52.6
              rust-windows-x86-64-gnu-0.48.5
              rust-windows-x86-64-gnu-0.52.6
              rust-windows-x86-64-gnullvm-0.48.5
              rust-windows-x86-64-gnullvm-0.52.6
              rust-windows-x86-64-msvc-0.48.5
              rust-windows-x86-64-msvc-0.52.6
              rust-wit-bindgen-rt-0.39.0
              rust-zerocopy-0.7.35
              rust-zerocopy-derive-0.7.35
              rust-zeroize-1.8.1
           )))
