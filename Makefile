all: start_here.ipynb

clean:
	rm start_here.ipynb

SNIPPETS := fabric-snippets/fab-config.md fabric-snippets/reserve-resources.md fabric-snippets/configure-resources.md fabric-snippets/offload-off.md fabric-snippets/draw-topo-detailed-labels.md fabric-snippets/log-in.md fabric-snippets/delete-slice.md
start_here.ipynb: $(SNIPPETS) intro.md exp-define.md
	pandoc --wrap=none \
                -i intro.md fabric-snippets/fab-config.md \
                exp-define.md \
                fabric-snippets/reserve-resources-eduky.md fabric-snippets/configure-resources.md \
				fabric-snippets/offload-off.md \
				fabric-snippets/draw-topo-detailed-labels.md fabric-snippets/log-in.md \
				fabric-snippets/delete-slice.md \
                -o start_here.ipynb  
