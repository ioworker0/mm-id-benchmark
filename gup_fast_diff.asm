--- /tmp/gup_fast_before.asm	2026-03-04 14:30:38.727958598 +0800
+++ /tmp/gup_fast_after.asm	2026-03-04 14:55:41.339946434 +0800
@@ -12,7 +12,7 @@
 ffffffff815c2df8:	41 55                	push   %r13
 ffffffff815c2dfa:	41 54                	push   %r12
 ffffffff815c2dfc:	53                   	push   %rbx
-ffffffff815c2dfd:	48 83 ec 10          	sub    $0x10,%rsp
+ffffffff815c2dfd:	48 83 ec 18          	sub    $0x18,%rsp
 ffffffff815c2e01:	65 48 8b 1d ff 81 a0 	mov    %gs:0x1a081ff(%rip),%rbx        # ffffffff82fcb008 <__stack_chk_guard>
 ffffffff815c2e08:	01
 ffffffff815c2e09:	48 89 5d d0          	mov    %rbx,-0x30(%rbp)
@@ -25,51 +25,51 @@
 ffffffff815c2e27:	4d 85 e4             	test   %r12,%r12
 ffffffff815c2e2a:	0f 85 14 01 00 00    	jne    ffffffff815c2f44 <gup_fast+0x154>
 ffffffff815c2e30:	41 89 d7             	mov    %edx,%r15d
-ffffffff815c2e33:	41 81 e7 00 00 08 00 	and    $0x80000,%r15d
-ffffffff815c2e3a:	74 20                	je     ffffffff815c2e5c <gup_fast+0x6c>
-ffffffff815c2e3c:	65 48 8b 05 d4 81 a0 	mov    %gs:0x1a081d4(%rip),%rax        # ffffffff82fcb018 <current_task>
-ffffffff815c2e43:	01
-ffffffff815c2e44:	48 8b 80 38 09 00 00 	mov    0x938(%rax),%rax
+ffffffff815c2e33:	65 4c 8b 35 dd 81 a0 	mov    %gs:0x1a081dd(%rip),%r14        # ffffffff82fcb018 <current_task>
+ffffffff815c2e3a:	01
+ffffffff815c2e3b:	41 81 e7 00 00 08 00 	and    $0x80000,%r15d
+ffffffff815c2e42:	74 18                	je     ffffffff815c2e5c <gup_fast+0x6c>
+ffffffff815c2e44:	49 8b 86 38 09 00 00 	mov    0x938(%r14),%rax
 ffffffff815c2e4b:	44 8b a8 78 02 00 00 	mov    0x278(%rax),%r13d
 ffffffff815c2e52:	41 f6 c5 01          	test   $0x1,%r13b
 ffffffff815c2e56:	0f 85 e8 00 00 00    	jne    ffffffff815c2f44 <gup_fast+0x154>
-ffffffff815c2e5c:	ff 15 a6 c4 27 01    	call   *0x127c4a6(%rip)        # ffffffff8283f308 <pv_ops+0xe8>
-ffffffff815c2e62:	49 89 c6             	mov    %rax,%r14
-ffffffff815c2e65:	ff 15 a5 c4 27 01    	call   *0x127c4a5(%rip)        # ffffffff8283f310 <pv_ops+0xf0>
-ffffffff815c2e6b:	4c 8d 45 cc          	lea    -0x34(%rbp),%r8
-ffffffff815c2e6f:	48 89 d9             	mov    %rbx,%rcx
-ffffffff815c2e72:	e8 29 fc ff ff       	call   ffffffff815c2aa0 <gup_fast_pgd_range>
-ffffffff815c2e77:	41 f7 c6 00 02 00 00 	test   $0x200,%r14d
-ffffffff815c2e7e:	74 06                	je     ffffffff815c2e86 <gup_fast+0x96>
-ffffffff815c2e80:	ff 15 92 c4 27 01    	call   *0x127c492(%rip)        # ffffffff8283f318 <pv_ops+0xf8>
-ffffffff815c2e86:	45 85 ff             	test   %r15d,%r15d
-ffffffff815c2e89:	74 1a                	je     ffffffff815c2ea5 <gup_fast+0xb5>
-ffffffff815c2e8b:	65 48 8b 05 85 81 a0 	mov    %gs:0x1a08185(%rip),%rax        # ffffffff82fcb018 <current_task>
-ffffffff815c2e92:	01
-ffffffff815c2e93:	48 8b 80 38 09 00 00 	mov    0x938(%rax),%rax
-ffffffff815c2e9a:	8b 80 78 02 00 00    	mov    0x278(%rax),%eax
-ffffffff815c2ea0:	41 39 c5             	cmp    %eax,%r13d
-ffffffff815c2ea3:	75 09                	jne    ffffffff815c2eae <gup_fast+0xbe>
-ffffffff815c2ea5:	48 63 45 cc          	movslq -0x34(%rbp),%rax
-ffffffff815c2ea9:	e9 98 00 00 00       	jmp    ffffffff815c2f46 <gup_fast+0x156>
-ffffffff815c2eae:	4c 63 6d cc          	movslq -0x34(%rbp),%r13
-ffffffff815c2eb2:	45 85 ed             	test   %r13d,%r13d
-ffffffff815c2eb5:	0f 84 89 00 00 00    	je     ffffffff815c2f44 <gup_fast+0x154>
-ffffffff815c2ebb:	4a 8b 3c e3          	mov    (%rbx,%r12,8),%rdi
-ffffffff815c2ebf:	45 89 e0             	mov    %r12d,%r8d
-ffffffff815c2ec2:	48 8b 47 08          	mov    0x8(%rdi),%rax
-ffffffff815c2ec6:	48 89 c2             	mov    %rax,%rdx
-ffffffff815c2ec9:	83 e2 01             	and    $0x1,%edx
-ffffffff815c2ecc:	48 83 ea 01          	sub    $0x1,%rdx
-ffffffff815c2ed0:	48 09 d0             	or     %rdx,%rax
-ffffffff815c2ed3:	48 21 c7             	and    %rax,%rdi
-ffffffff815c2ed6:	41 8d 44 24 01       	lea    0x1(%r12),%eax
-ffffffff815c2edb:	48 89 c6             	mov    %rax,%rsi
-ffffffff815c2ede:	4c 39 e8             	cmp    %r13,%rax
-ffffffff815c2ee1:	72 28                	jb     ffffffff815c2f0b <gup_fast+0x11b>
-ffffffff815c2ee3:	e9 89 00 00 00       	jmp    ffffffff815c2f71 <gup_fast+0x181>
-ffffffff815c2ee8:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
-ffffffff815c2eef:	00 00 00 00
+ffffffff815c2e5c:	49 8b 8e 38 09 00 00 	mov    0x938(%r14),%rcx
+ffffffff815c2e63:	b8 01 00 00 00       	mov    $0x1,%eax
+ffffffff815c2e68:	f0 48 0f c1 81 90 05 	lock xadd %rax,0x590(%rcx)
+ffffffff815c2e6f:	00 00
+ffffffff815c2e71:	ff 15 91 c4 27 01    	call   *0x127c491(%rip)        # ffffffff8283f308 <pv_ops+0xe8>
+ffffffff815c2e77:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
+ffffffff815c2e7b:	ff 15 8f c4 27 01    	call   *0x127c48f(%rip)        # ffffffff8283f310 <pv_ops+0xf0>
+ffffffff815c2e81:	4c 8d 45 cc          	lea    -0x34(%rbp),%r8
+ffffffff815c2e85:	48 89 d9             	mov    %rbx,%rcx
+ffffffff815c2e88:	e8 13 fc ff ff       	call   ffffffff815c2aa0 <gup_fast_pgd_range>
+ffffffff815c2e8d:	f6 45 c1 02          	testb  $0x2,-0x3f(%rbp)
+ffffffff815c2e91:	74 06                	je     ffffffff815c2e99 <gup_fast+0xa9>
+ffffffff815c2e93:	ff 15 7f c4 27 01    	call   *0x127c47f(%rip)        # ffffffff8283f318 <pv_ops+0xf8>
+ffffffff815c2e99:	45 85 ff             	test   %r15d,%r15d
+ffffffff815c2e9c:	74 12                	je     ffffffff815c2eb0 <gup_fast+0xc0>
+ffffffff815c2e9e:	49 8b 86 38 09 00 00 	mov    0x938(%r14),%rax
+ffffffff815c2ea5:	8b 80 78 02 00 00    	mov    0x278(%rax),%eax
+ffffffff815c2eab:	41 39 c5             	cmp    %eax,%r13d
+ffffffff815c2eae:	75 09                	jne    ffffffff815c2eb9 <gup_fast+0xc9>
+ffffffff815c2eb0:	48 63 45 cc          	movslq -0x34(%rbp),%rax
+ffffffff815c2eb4:	e9 8d 00 00 00       	jmp    ffffffff815c2f46 <gup_fast+0x156>
+ffffffff815c2eb9:	4c 63 6d cc          	movslq -0x34(%rbp),%r13
+ffffffff815c2ebd:	45 85 ed             	test   %r13d,%r13d
+ffffffff815c2ec0:	0f 84 7e 00 00 00    	je     ffffffff815c2f44 <gup_fast+0x154>
+ffffffff815c2ec6:	4a 8b 3c e3          	mov    (%rbx,%r12,8),%rdi
+ffffffff815c2eca:	45 89 e0             	mov    %r12d,%r8d
+ffffffff815c2ecd:	48 8b 47 08          	mov    0x8(%rdi),%rax
+ffffffff815c2ed1:	48 89 c2             	mov    %rax,%rdx
+ffffffff815c2ed4:	83 e2 01             	and    $0x1,%edx
+ffffffff815c2ed7:	48 83 ea 01          	sub    $0x1,%rdx
+ffffffff815c2edb:	48 09 d0             	or     %rdx,%rax
+ffffffff815c2ede:	48 21 c7             	and    %rax,%rdi
+ffffffff815c2ee1:	41 8d 44 24 01       	lea    0x1(%r12),%eax
+ffffffff815c2ee6:	48 89 c6             	mov    %rax,%rsi
+ffffffff815c2ee9:	4c 39 e8             	cmp    %r13,%rax
+ffffffff815c2eec:	72 1d                	jb     ffffffff815c2f0b <gup_fast+0x11b>
+ffffffff815c2eee:	e9 7e 00 00 00       	jmp    ffffffff815c2f71 <gup_fast+0x181>
 ffffffff815c2ef3:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
 ffffffff815c2efa:	00 00 00 00
 ffffffff815c2efe:	66 90                	xchg   %ax,%ax
@@ -92,13 +92,13 @@
 ffffffff815c2f33:	4d 01 f4             	add    %r14,%r12
 ffffffff815c2f36:	e8 e5 da ff ff       	call   ffffffff815c0a20 <gup_put_folio>
 ffffffff815c2f3b:	4d 39 ec             	cmp    %r13,%r12
-ffffffff815c2f3e:	0f 82 77 ff ff ff    	jb     ffffffff815c2ebb <gup_fast+0xcb>
+ffffffff815c2f3e:	0f 82 82 ff ff ff    	jb     ffffffff815c2ec6 <gup_fast+0xd6>
 ffffffff815c2f44:	31 c0                	xor    %eax,%eax
 ffffffff815c2f46:	48 8b 55 d0          	mov    -0x30(%rbp),%rdx
 ffffffff815c2f4a:	65 48 2b 15 b6 80 a0 	sub    %gs:0x1a080b6(%rip),%rdx        # ffffffff82fcb008 <__stack_chk_guard>
 ffffffff815c2f51:	01
 ffffffff815c2f52:	75 2a                	jne    ffffffff815c2f7e <gup_fast+0x18e>
-ffffffff815c2f54:	48 83 c4 10          	add    $0x10,%rsp
+ffffffff815c2f54:	48 83 c4 18          	add    $0x18,%rsp
 ffffffff815c2f58:	5b                   	pop    %rbx
 ffffffff815c2f59:	41 5c                	pop    %r12
 ffffffff815c2f5b:	41 5d                	pop    %r13
