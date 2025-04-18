# 🐧 Linux Automation

# Q2 – Archive Permission Fix & Repack

Scenario:

Complete the file stub located at `q2/runscript.sh` with one or more commands to achieve the following tasks:

- Extract the archive located at `/q2/backup.tar.gz`.
- Set permission "0664" for all the files that were just extracted.
- Set permission "0775" for all the directories that were just extracted.
- Change the owner to "anonymous" and the group to "no-team" for all the extracted files and directories.
- Create a new archive with the adjusted files and directories, naming it `/tmp/fixed-archive.tar.gz`.

---

**Notes:**

- solution are evaluated in a new, clean setup. Make sure all work is performed in the `/q2` directory.
- Execute all tasks with a single `sudo activate` command run from within the question directory. (Hint: use alias)
- You have sudo permissions, if needed.

 ---

**Solution:**
# Q2 – Archive Permission Fix & Repack

This task focuses on extracting an archive, adjusting file/directory permissions and ownership, and repackaging it with the updated metadata.

---

## 🗂️ Task Overview

- Extract the archive: `/q2/backup.tar.gz`
- Set permissions:
  - Files: `0664`
  - Directories: `0775`
- Change ownership:
  - User: `anonymous`
  - Group: `no-team`
- Recreate the archive as `/tmp/fixed-archive.tar.gz`

---

## 🔧 Script Location

```bash
q2/runscript.sh

---

📜 Script Breakdown
#! /bin/bash

#change to the /q2 directory
cd /q2 || exit 1

#extract the archive
tar -xzf backup.tar.gz

#set permissions:0664 for files and 0775 for directories
find . -type f -exec chmod 0664 {} +
find . -type d -exec chmod 0775 {} +

#change ownership to user "anonymous" and gorup "no-team"
chown -R anonymous:no-team

#create fixed archive 
tar -czf /tmp/fixed-archive.tar.gz .

```

⚙️ Activate Command
To standardize execution, the system uses an alias:

sudo activate

This alias is expected to point to the script in the current directory (i.e., runscript.sh). When executed, it performs all the required actions in one go.

---

🧪 Usage
From inside the q2 directory:

sudo activate
✅ This ensures the script runs in a controlled environment using root privileges when needed.

---

📌 Notes
Ensure anonymous user and no-team group exist.

Archive is extracted and re-created in the same working directory (/q2).

Output archive is stored at: /tmp/fixed-archive.tar.gz

---

✅ Output
A new compressed archive with updated permissions and ownership:

/tmp/fixed-archive.tar.gz

🛠️ Author
Maintained by
![Logo](assets/logo.png)
<p align="center"><em>DevOps Engineer • Nivedha Muthukrishnan</em></p>
