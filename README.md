![VDG Cover](/images/github-cover.png)

# The Linux Sysadmin's Guide to Virtual Disks

The Linux Sysadmin's Guide to Virtual Disks demonstrates the core
concepts of virtual disk management. Real-world problems are covered
in this book's "Cookbook" section. Included are examples across the
difficulty spectrum, from the basic printing of a disk's meta-data, to
cloning physical disks into virtual disks. Disk format conversion and
disk resizing are both covered in-depth.

Topics include, the Virtual disk cookbook, helper utilities, disk
formats, troubleshooting, and performance considerations.

The Linux Sysadmin's Guide to Virtual Disks is written in a tone that
is approachable to both newcomers, and experienced veterans.  No
matter what your experience level, you're guaranteed to learn
something new.


## Read the book online for free:

* HTML: http://lnx.cx/docs/vdg/output/Virtual-Disk-Operations.html
* PDF: http://lnx.cx/docs/vdg/output/Virtual-Disk-Operations.pdf

## Buy a physical copy to support the author:

If you have enjoyed the Virtual Disk Guide, consider buying a physical
copy to show your support. Or not, no pressure.

* [Lulu.com: Virtual Disk Guide](http://www.lulu.com/shop/tim-bielawa/the-linux-sysadmins-guide-to-virtual-disks/paperback/product-22572755.html)


# Table of Contents

- 0. Acknowledgements
- 1. Introduction
- 1.1. Introduction
- 1.2. Typographical Conventions
- 1.3. Units & Prefixes
- 1.4. Getting Help/Feedback
- 1.5. About The Author
- 2. The Virtual Disk Cookbook
- 2.1. Creating Simple Images
- 2.2. Resizing Disk Images
- 2.2.1. Resizing RAW Images
- 2.2.2. Resizing QCOW2 Images
- 2.3. Query an Image for Information
- 2.4. Converting Between RAW and QCOW2
- 2.4.1. Convert an Image from RAW to QCOW2
- 2.4.2. Convert an Image from QCOW2 to RAW
- 2.5. Creating Disks with Backing Images
- 2.6. Comitting changes to a backing image
- 2.7. Cloning a Physical Disk
- 3. Disk Concepts
- 3.1. Creating a 1GiB virtual disk from scratch
- 3.1.1. Background on the dd command
- 3.1.2. Running dd
- 3.1.3. Examining the Created File
- 3.1.4. Create a Partition Table
- 3.2. Devices and Partitions
- 3.2.1. Introduction
- 3.2.2. Creating a Loop Device
- 3.2.3. Examine the loop device
- 3.2.4. Creating partitions
- 3.2.5. Formatting Partitions
- 3.2.6. Cleaning Up
- 4. Helper Utilities
- 4.1. libguestfs
- 4.1.1. guestmount
- 4.1.2. virt-filesystems
- 4.1.3. virt-rescue
- 4.1.4. virt-resize
- 4.1.5. virt-sparsify
- 4.2. virt manager
- 5. Disk Formats
- 5.1. RAW
- 5.2. QCOW
- 5.3. QCOW2
- 5.4. Other Formats
- 6. Performance Considerations
- 6.1. I/O Caching
- 6.1.1. Write-back Caching
- 6.1.2. Write-through Caching
- 6.2. I/O Schedulers
- 6.2.1. Additional Resources
- 7. Troubleshooting/FAQs
- A. Appendix: Man Pages
- UNITS — decimal and binary prefixes
- B. Appendix: Disk Drive History
- B.1. Disk Drive Components
- B.2. Access Modes
- B.2.1. CHS Addressing
- B.2.2. LBA Addressing
- B.3. The Master Boot Record
- Glossary
- Colophone


# Building the Document

Compiling this documentation requires:
* xsltproc
* dblatex
* docboook5 stylesheets (http://sourceforge.net/projects/docbook/files/docbook-xsl-ns/)
* make
* Adobe Source Code Pro/Source Sans Pro fonts (store *.ttf files in ~/.fonts/)

Fedora Packages with some of these dependencies:
* xsltprox available in libxslt
* dblatex available in dblatex


There is a basic setup script in ``misc/setup-docbook.sh``.
