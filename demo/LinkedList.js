var LinkedList = function() {
    const Node = function(element) {
        this.element = element
        this.next = null
    }

    let head = null
    let current 
    let length = 0

    this.append = function(element) {
        const node = new Node(element)
        if (head === null) {
            head = node
        } else {
            current = head
            while(current.next) {
                current = current.next
            }
            current.next = node
        }
        length++
    }

    this.removeAt = function(position) {
        if (position > -1 && position < length) {
            let previous
            let index = 0
            if (position === 0) {
                head = head.next
            } else {
                current = head
                while(index < position) {
                    previous = current
                    current = current.next
                    index++
                }
                previous.next = current.next
            }
            length--
        }
    }

    this.insert = function(element, position) {
        const node = new Node(element)
        let index = 0
        let current, previous
        if (position > -1 && position < length + 1) {
            if (position === 0) {
                current = head
                head = node
                head.next = current
            } else {
                current = head
                if (index < position) {
                    previous = current
                    current = current.next
                    index++
                }
                previous.next = node
                node.next = current
            }
            length++
        }
    }

    this.indexOf = function(element) {
        let index = 0
        let current = head
        while(index < length) {
            if(current.element === element) {
                return index
            }
            current = current.next
            index++
        } 
        return -1
    }

    this.remove = function(element) {
        const position = this.indexOf(element)
        this.removeAt(position)
    }

    this.size = function() {
        return length
    }

    this.getHead = function() {
        return head
    }

    this.isEmpty = function() {
        return length === 0
    }

    this.log = function() {
        let current = head
        let str = current.element
        while(current.next) {
            current = current.next
            str =  str +  ' ' + current.element
        }
        return console.log(str)
    }
}
var link = new LinkedList()
link.append(5)
link.append(10)
link.append(15)
link.append(20)
link.append(25)
link.log()
reverse(link)
link.log()

function reverse(linkList) {
    let head = linkList.head
    if (head == null || head.next == null) {
        return
    }
    var p, q, r
    p = head
    q = p.next
    head.next = null
    while(q){
        r = q.next
        q.next = p
        p = q
        q = r
    }
    linkList.head = p
}
