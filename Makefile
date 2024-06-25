all: start_here.ipynb

clean:
	rm start_here.ipynb

SNIPPETS := fabric-snippets/fab-config.md fabric-snippets/configure-resources.md fabric-snippets/offload-off.md fabric-snippets/draw-topo-detailed-labels.md fabric-snippets/log-in.md fabric-snippets/delete-slice.md
start_here.ipynb: $(SNIPPETS) custom-snippets/intro.md custom-snippets/exp-define.md custom-snippets/reserve-resources-eduky.md
	pandoc --wrap=none \
                -i custom-snippets/intro.md fabric-snippets/fab-config.md \
                custom-snippets/exp-define.md \
                custom-snippets/reserve-resources-eduky.md fabric-snippets/configure-resources.md \
				fabric-snippets/offload-off.md \
				fabric-snippets/draw-topo-detailed-labels.md fabric-snippets/log-in.md \
				fabric-snippets/delete-slice.md \
                -o start_here.ipynb  