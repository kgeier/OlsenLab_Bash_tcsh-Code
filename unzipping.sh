
#!/bin/bash
for i in {1026..1028}; do 
	cd ${i}
	mkdir raw
	mv *.zip raw
	unzip raw/*MRI*.zip
	cd ..
done
