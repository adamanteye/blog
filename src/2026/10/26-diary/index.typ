#import "/page.typ": *
#import "meta.typ": desc, title
#show: conf.with(title: title, desc: desc)

今天下午去物理楼诊断两个交换机, 发现自己蠢到 copy-paste systemd-networkd 的配置,
却没有改 MAC 地址, 内网里面两个机器地址重了. 当然也得怪当时装系统没有改
machine-id. 在此推荐 gping 工具: ICMP 包的时间相关性在诊断这类错误时非常重要.

被他们的企业级 sudo 配置坑到了, 教训是配网一定用 root 账号.

交换机一定要有挂耳, 并且一定要放在机柜最上面.
